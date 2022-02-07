resource "google_compute_firewall" "default" {
  name          = "l7-ilb-fw-allow-hc"
  direction     = "INGRESS"
  network       = var.network_id
  project       = var.project_id
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16", "35.235.240.0/20"]

  allow {
    protocol = "tcp"
  }
}

# Allow http from proxy subnet to backends
resource "google_compute_firewall" "backends" {
  name          = "l7-ilb-fw-allow-ilb-to-backends"
  direction     = "INGRESS"
  network       = var.network_id
  project       = var.project_id
  source_ranges = var.source_ranges
  target_tags   = var.target_tags

  allow {
    protocol = "tcp"
    ports    = var.ports
  }
}
