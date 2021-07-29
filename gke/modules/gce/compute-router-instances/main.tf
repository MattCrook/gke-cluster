## router service account

resource "google_service_account" "router_sa" {
  account_id   = "${var.name}-sa"
  display_name = "Service account used for router"
  project      = "${var.project_name}"
}

## router instance addresses

resource "google_compute_address" "mgmt" {
  project = "${var.project_name}"
  count   = "${var.count}"
  name    = "${var.name}-${replace(element(var.zones, count.index), "/^(..).*-(.).*(.)-.*(.)$/", "$1$2$3$4")}-${count.index + 1}"
  region  = "${var.region}"
}

## router instances

resource "google_compute_instance" "instance" {
  depends_on     = ["google_compute_address.mgmt"]
  project        = "${var.project_name}"
  count          = "${var.count}"
  name           = "${var.name}-${replace(element(var.zones, count.index), "/^(..).*-(.).*(.)-.*(.)$/", "$1$2$3$4")}-${count.index + 1}"
  zone           = "${element(var.zones, count.index)}"
  machine_type   = "${element(var.type, count.index)}"
  can_ip_forward = "${var.ipforward}"
  tags           = ["${var.tags}"]

  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "${element(var.disk_image, count.index)}"
      size  = "${element(var.disk_size, count.index)}"
      type  = "${element(var.disk_type, count.index)}"
    }

    auto_delete = "${element(var.disk_autodelete, count.index)}"
  }

  # Management interface
  network_interface {
    subnetwork_project = "${var.subnetwork_project}"
    subnetwork         = "${var.subnetwork}"

    access_config {
      // Ephemeral IP
      nat_ip = "${element(google_compute_address.mgmt.*.address, count.index)}"
    }
  }

  service_account {
    email  = "${google_service_account.router_sa.email}"
    scopes = ["${concat(var.serviceaccount_scopes,var.extra_scopes)}"]
  }

  metadata {
    sshKeys = "${var.router_ssh_user}:${file("${path.module}/files/c3r_id_rsa.pub")}"
  }
}

## Random ID generation for serial numbers

resource "random_uuid" "sn" {
  count = "${var.count}"
}

resource "random_uuid" "ha" {}

## router instance provisioner

resource "random_uuid" "provisioner" {
  depends_on = ["google_compute_instance.instance"]
  count      = "${var.count}"

  connection {
    type        = "ssh"
    user        = "${var.router_ssh_user}"
    private_key = "${file("${var.router_ssh_key}")}"
    timeout     = "10m"

    host = "${var.c3r_backplane == 1 ? element(google_compute_instance.instance.*.network_interface.0.address, count.index) : element(google_compute_address.mgmt.*.address, count.index)}"
  }

  provisioner "file" {
    content     = "${file("${var.c3r_credentials}")}"
    destination = "/root/auth.json"
  }

  provisioner "file" {
    content     = "${element(data.template_file.router_yaml.*.rendered, count.index)}"
    destination = "/root/.router.yaml"
  }

  provisioner "file" {
    content     = "${replace(element(random_uuid.sn.*.result, count.index), "-", "")}"
    destination = "/root/.SerialNumber"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt install -y curl",
      "sudo curl -fsSL get.docker.com -o get-docker.sh",
      "sudo chmod +x get-docker.sh",
      "sudo sh get-docker.sh",
      "wget https://storage.googleapis.com/c3r-device-state/binary/router-amd64-${var.router_version}",
      "sudo mv router-amd64-${var.router_version} /usr/bin/router",
      "sudo chmod +x /usr/bin/router",
      "sudo /usr/bin/router join version",
      "sudo /usr/bin/router join",
    ]
  }
}

## router yaml template provisioner

data "template_file" "router_yaml" {
  template = "${file("${path.module}/files/router.yaml.tmpl")}"
  count    = "${var.count}"

  vars {
    router_version                                = "${var.router_version}"
    gcp_private_bridge                            = "${var.gcp_private_bridge}"
    kubernetes_peer                               = "${var.kubernetes_peer}"
    device_name                                   = "${var.name}-${replace(var.region, "/^(..).*-(.).*(.)$/", "$1$2$3")}-${count.index + 1}"
    project_id                                    = "${var.project_name}"
    network                                       = "${var.network}"
    serial_number                                 = "${replace(element(random_uuid.sn.*.result, count.index), "-", "")}"
    ha_set                                        = "${replace(random_uuid.ha.result, "-", "")}"
    high_availability                             = "${var.high_availability ? true : false }"
    haadminup                             = "${var.high_availability ? true : false }"
    c3_token                                      = "${var.c3_token}"
    hosted_project                                = "${var.project_name}"
    ha_routes                                     = "${indent(8, var.service_configs_ha_routes)}"
    ip_address                                    = "${element(google_compute_instance.instance.*.network_interface.0.address, count.index)}"
    instance_id                                   = "${element(google_compute_instance.instance.*.instance_id, count.index)}"
    region                                        = "${var.region}"
    zone                                          = "${element(var.zones, count.index)}"
    static_ip                                     = "${var.vxlan_static_ip[count.index]}"
    setmss                                        = "${var.set_mss}"
    discovery_record_vxlan                        = "${var.discovery_record_vxlan}"
    discovery_record_scope                        = "${var.discovery_record_scope}"
    primary_interface_advertisement               = "${var.primary_interface_advertisement}"
    advertise_primary_ip                          = "${var.advertise_primary_ip}"
    vxlan_private_subnet                          = "${var.vxlan_private_subnet}"
    vxlan_environment                             = "${var.vxlan_environment}"
    authentication_gcp_project_id                 = "${var.authentication_gcp_project_id}"
    encryption_gcp_keyring_id                     = "${var.encryption_gcp_keyring_id}"
    encryption_gcp_cryptokey_id                   = "${var.encryption_gcp_cryptokey_id}"
    encryption_gcp_location                       = "${var.encryption_gcp_location}"
    storage_gcp_bucket                            = "${var.storage_gcp_bucket}"
    services_vxlan                                = "${var.services_vxlan ? true : false }"
    services_scope_dashboard                      = "${var.services_scope_dashboard ? true : false }"
    services_netdata                              = "${var.services_netdata ? true : false }"
    services_cadvisor                             = "${var.services_cadvisor ? true : false }"
    services_bgp                                  = "${var.services_bgp ? true : false }"
    services_prometheus                           = "${var.services_prometheus ? true : false }"
    services_ipsla                                = "${var.services_ipsla ? true : false }"
    services_slack                                = "${var.services_slack ? true : false }"
    services_scope                                = "${var.services_scope ? true : false }"
    services_c3                                   = "${var.services_c3 ? true : false }"
    services_nat                                  = "${var.services_nat ? true : false }"
    services_hostapd                              = "${var.services_hostapd ? true : false }"
    services_loadbalancer                         = "${var.services_loadbalancer ? true : false }"
    services_teleport                             = "${var.services_teleport ? true : false }"
    services_configs_api_encryptedcredspath       = "${var.services_configs_api_encryptedcredspath}"
    prometheus_host_tags                          = "${indent(6, local.hosttags)}"
    services_configs_bgp                          = "${indent(6, var.services_configs_bgp)}"
    services_configs_routes                       = "${indent(6, var.services_configs_routes)}"
    services_configs_ipsla                          = "${indent(6, var.services_configs_ipsla)}"
    services_configs_nat_rules                    = "${indent(4, var.services_configs_nat_rules)}"
    services_configs_loadbalancer                 = "${indent(4, var.services_configs_loadbalancer)}"
    services_configs_hostapd                      = "${indent(4, var.services_configs_hostapd)}"
    services_configs_slack_webhook                = "${var.services_configs_slack_webhook}"
    services_configs_slack_channel                = "${var.services_configs_slack_channel}"
    services_configs_router_memory                = "${jsonencode(var.services_configs_router_memory)}"
    services_configs_router_memory_swap           = "${jsonencode(var.services_configs_router_memory_swap)}"
    services_configs_router_memory_reservation    = "${jsonencode(var.services_configs_router_memory_reservation)}"
    services_configs_router_cpus                  = "${var.services_configs_router_cpus}"
    services_configs_scheduler_memory             = "${jsonencode(var.services_configs_scheduler_memory)}"
    services_configs_scheduler_memory_swap        = "${jsonencode(var.services_configs_scheduler_memory_swap)}"
    services_configs_scheduler_memory_reservation = "${jsonencode(var.services_configs_scheduler_memory_reservation)}"
    services_configs_scheduler_cpus               = "${var.services_configs_scheduler_cpus}"
    services_configs_snmp_rocommunity             = "${var.services_configs_snmp_rocommunity}"
    upgrade_bucket                                = "${var.upgrade_bucket}"
    service_configs_scope_proxy                   = "${var.service_configs_scope_proxy}"
    registry_images                               = "${indent(4, var.registry_images)}"
    ha_set                                        = "${replace(random_uuid.ha.result, "-", "")}"
    high_availability                             = "${var.high_availability ? true : false }"
    c3_token                                      = "${var.c3_token}"
    ha_routes                                     = "${indent(6, var.services_configs_ha_routes)}"
    ip_address                                    = "${element(google_compute_instance.instance.*.network_interface.0.address, count.index)}"
    instance_id                                   = "${element(google_compute_instance.instance.*.instance_id, count.index)}"
    region                                        = "${var.region}"
    zone                                          = "${element(var.zones, count.index)}"
    services_c3                                   = "${var.services_c3 ? true : false }"
  }
}

## router firewall rules

resource "google_compute_firewall" "firewall-esp" {
  project   = "${var.project_name}"
  name      = "${var.name}-${replace(var.region, "/^(..).*-(.).*(.)$/", "$1$2$3")}-esp"
  network   = "${var.network}"
  priority  = "1000"
  direction = "INGRESS"

  allow {
    protocol = "esp"
  }

  source_ranges           = ["0.0.0.0/0"]
  target_service_accounts = ["${google_service_account.router_sa.email}"]
}

resource "google_compute_firewall" "firewall-tcp" {
  project   = "${var.project_name}"
  name      = "${var.name}-${replace(var.region, "/^(..).*-(.).*(.)$/", "$1$2$3")}-tcp"
  network   = "${var.network}"
  priority  = "1000"
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["6783"]
  }

  source_ranges           = ["0.0.0.0/0"]
  target_service_accounts = ["${google_service_account.router_sa.email}"]
}

resource "google_compute_firewall" "firewall-allow-private" {
  project   = "${var.project_name}"
  name      = "${var.name}-${replace(var.region, "/^(..).*-(.).*(.)$/", "$1$2$3")}-allow-private"
  network   = "${var.network}"
  priority  = "1000"
  direction = "INGRESS"

  allow {
    protocol = "tcp"
  }

  source_ranges           = ["10.0.0.0/8", "100.68.0.0/16"]
  target_service_accounts = ["${google_service_account.router_sa.email}"]
}

resource "google_compute_firewall" "firewall-udp" {
  project   = "${var.project_name}"
  name      = "${var.name}-${replace(var.region, "/^(..).*-(.).*(.)$/", "$1$2$3")}-udp"
  network   = "${var.network}"
  priority  = "1000"
  direction = "INGRESS"

  allow {
    protocol = "udp"
    ports    = ["6783", "6784"]
  }

  source_ranges           = ["0.0.0.0/0"]
  target_service_accounts = ["${google_service_account.router_sa.email}"]
}

resource "google_compute_firewall" "firewall-ssh" {
  project   = "${var.project_name}"
  name      = "${var.name}-${replace(var.region, "/^(..).*-(.).*(.)$/", "$1$2$3")}-ssh"
  network   = "${var.network}"
  priority  = "1000"
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges           = ["0.0.0.0/0"]
  target_service_accounts = ["${google_service_account.router_sa.email}"]
}

## c3router gcs config & state files

resource "google_storage_bucket_object" "config_object" {
  count        = "${var.count}"
  name         = "devices/configuration/environments/core-services/devices/${replace(element(random_uuid.sn.*.result, count.index), "-", "")}/running-config/state-config.yaml"
  content      = "${element(data.template_file.router_yaml.*.rendered, count.index)}"
  bucket       = "${var.storage_gcp_bucket}"
  content_type = "${var.content_type}"
}

resource "google_storage_bucket_object" "state_object" {
  count        = "${var.count}"
  name         = "devices/configuration/environments/core-services/devices/${replace(element(random_uuid.sn.*.result, count.index), "-", "")}/running-config/tf-build-state.yaml"
  content      = "${element(data.template_file.router_yaml.*.rendered, count.index)}"
  bucket       = "${var.storage_gcp_bucket}"
  content_type = "${var.content_type}"
}

## Prometheus tag generation

locals {
  hosttags = <<YAML
HostTags:
Tags:
  device_name: "${var.name}-${replace(var.region, "/^(..).*-(.).*(.)$/", "$1$2$3")}"
  env: "${var.vxlan_environment}"
  ha_set: "${var.name}-${replace(var.region, "/^(..).*-(.).*(.)$/", "$1$2$3")}"
  provider: gcp
  region: "${var.region}"
  business: "${var.business}"
YAML
}
