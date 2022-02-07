resource "google_compute_instance_group" "region_instance_group" {
  project                   = var.project_id
  zone                      = var.zone
  name                      = google_compute_instance.webserver[each.key].name
  description               = "Un Managed Instance Group responsible for managing all webserver instances."
  network                   = var.network_id

  instances = [google_compute_instance.webserver[each.key].id]

  named_port {
    name = "http"
    port = "80"
  }

  named_port {
    name = "http"
    port = "443"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance" "webserver" {
  name           = "internal-${var.env_abbreviation}-webserver"
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
