#############################################
# External TCP LoadBalancer
#############################################
resource "google_compute_forwarding_rule" "tcp_l4_xlb_fowarding_rule" {
  project               = var.project_id
  region                = var.region
  name                  = var.fw_name
  description           = var.fw_description
  target                = google_compute_target_pool.test_instance_target_pool.self_link
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  all_ports             = var.all_ports
  port_range            = var.port_range
  labels                = var.fw_labels
}

resource "google_compute_target_pool" "test_instance_target_pool" {
  project          = var.project_id
  region           = var.region
  name             = var.target_pool_name
  description      = "Target pool used as target of a network load balancer (Forwarding Rule)."
  session_affinity = var.session_affinity
  instances        = [google_compute_instance.webserver.self_link]
  health_checks    = [google_compute_http_health_check.tcp.name]
}


resource "google_compute_instance" "webserver" {
  name           = var.instance_name
  description    = var.webserver_description
  project        = var.project_id
  zone           = var.zone
  machine_type   = var.machine_type
  can_ip_forward = false
  labels         = var.labels
  tags           = var.tags

  allow_stopping_for_update = false
  metadata_startup_script   = var.metadata_startup_script

  metadata = {
    enable-oslogin = "TRUE"
  }

  boot_disk {
    auto_delete = true
    device_name = "boot-disk"

    initialize_params {
      image = var.source_image
      type = var.disk_type
      size = var.disk_size
    }
  }

  network_interface {
    network            = var.network_id
    subnetwork         = var.subnetwork
    subnetwork_project = var.project_id
  }

  service_account {
    email  = google_service_account.service_account.email
    scopes = ["cloud-platform"]
  }
}
