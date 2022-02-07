# allow all access from IAP and health check ranges
resource "google_compute_firewall" "fw-iap" {
  provider      = google-beta
  network       = var.network_id
  project       = var.project_id
  name          = "l7-ilb-fw-allow-iap-hc"
  direction     = "INGRESS"
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16", "35.235.240.0/20"]

  allow {
    protocol = "tcp"
  }
}

# allow http from proxy subnet to backends
resource "google_compute_firewall" "fw-ilb-to-backends" {
  provider      = google-beta
  network       = var.network_id
  project       = var.project_id
  name          = "l7-ilb-fw-allow-ilb-to-backends"
  direction     = "INGRESS"
  source_ranges = var.source_ranges
  target_tags   = var.target_tags

  allow {
    protocol = "tcp"
    ports    = var.ports
  }
}
