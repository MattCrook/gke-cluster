resource "google_compute_firewall" "default" {
  name          = "tcp-proxy-xlb-fw-allow-hc"
  provider      = google-beta
  direction     = "INGRESS"
  network       = google_compute_network.default.id
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]

  allow {
    protocol = "tcp"
  }

  target_tags = ["allow-health-check"]
}


resource "google_compute_firewall" "allow-all-to-instance" {
  name        = "allow-all-to-instance"
  project     = var.project_id
  network     = var.network_id
  direction   = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "8080"]
  }

  allow {
    protocol = "udp"
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["internal-webserver"]

  log_config {
    metadata = "EXCLUDE_ALL_METADATA"
  }
}
