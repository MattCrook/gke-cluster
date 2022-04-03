############################
# Global Static IP Address
############################
resource "google_compute_global_address" "default" {
  provider = google-beta
  name     = "tcp-proxy-xlb-ip"
}


############################
# TCP Proxy LoadBalancer
############################
resource "google_compute_global_forwarding_rule" "default" {
  provider              = google-beta
  project               = var.project_id
  name                  = "l4-tcp-global-forwarding-rule"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = 110
  target                = google_compute_target_tcp_proxy.default.self_link
  ip_address            = google_compute_global_address.default.address
  labels                = {env = "dev"}
  depends_on            = [google_compute_global_address.l7_node_04_xlb_global_address]
}

resource "google_compute_target_tcp_proxy" "default" {
  provider        = google-beta
  name            = "l4-tcp-xlb-target-proxy"
  backend_service = google_compute_backend_service.default.id
}

resource "google_compute_backend_service" "default" {
  provider                        = google-beta
  project                         = var.project_id
  name                            = "l4-tcp-xlb-backend-service"
  protocol                        = "TCP"
  port_name                       = "tcp"
  load_balancing_scheme           = "EXTERNAL"
  timeout_sec                     = 10
  connection_draining_timeout_sec = 10
  health_checks                   = [google_compute_health_check.tcp.id]

  backend {
    group           = google_compute_instance_group.default.id
    balancing_mode  = "UTILIZATION"
    max_utilization = 1.0
    capacity_scaler = 1.0
  }
}


#####################################
# Instance Template and Group Manager
######################################
resource "google_compute_instance_template" "instance_template" {
  name_prefix    = format("%s-", "test-instance-tpl-${var.env_abbreviation}")
  project        = var.project_id
  region         = "us-central1"
  machine_type   = "n2-standard-2"
  labels         = {scope = "internal", type = "test", env = "dev"}
  can_ip_forward = false
  tags           = ["internal-webserver", "allow-health-check"]

  metadata_startup_script = templatefile("./startup_script.sh", {
      ENV          = var.environment
      CLASS        = "test-instance"
      TYPE         = "test"
  })

  disk {
    source_image = "ubuntu-os-cloud/ubuntu-2004-lts"
    disk_type    = "pd-ssd"
    disk_size_gb = 50
    auto_delete  = true
    boot         = true
    device_name  = "boot-disk"
    labels = {
      purpose = "root-disk"
    }

    dynamic "disk_encryption_key" {
      for_each = compact([var.disk_encryption_key == null ? null : 1])
      content {
        kms_key_self_link = var.disk_encryption_key
      }
    }
  }

  service_account {
    email  = google_service_account.vm_instance_service_account.email
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  network_interface {
    network            = var.network_id
    subnetwork         = var.subnetwork
    subnetwork_project = var.subnetwork_project

    access_config {
      # add external ip to fetch packages
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  scheduling {
    preemptible       = false
    automatic_restart = true
  }

  metadata = {
    enable-oslogin = "TRUE"
  }
}


resource "google_compute_instance_from_template" "instance" {
  provider                 = google
  project                  = var.project_id
  name                     = "internal-instance-01"
  zone                     = "us-central1-a"
  source_instance_template = google_compute_instance_template.instance_template.id

  network_interface {
    network            = var.network_id
    subnetwork         = var.subnetwork
    subnetwork_project = var.subnetwork_project

    access_config {
      # add external ip to fetch packages
    }
  }
}


resource "google_compute_instance_group" "instance_group" {
  provider = google
  project  = var.project_id
  name     = "internal-instance-group-01"
  zone     = "us-central1-a"

  instances = [google_compute_instance_from_template.instance.self_link]

  named_port {
    name = "http"
    port = "80"
  }

  named_port {
    name = "https"
    port = "443"
  }

  named_port {
    name = "tcp"
    port = "110"
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "google_service_account" "vm_instance_service_account" {
  account_id   = "instance-uc1-sa"
  display_name = "Test Instance Service Account"
  description  = "Service account managed by Terraform."
}
