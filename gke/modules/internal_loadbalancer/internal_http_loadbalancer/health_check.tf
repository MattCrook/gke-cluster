resource "google_compute_region_health_check" "default" {
  provider = google-beta
  region   = var.region
  name     = "l7-ilb-hc"

  http_health_check {
    port_specification = "USE_SERVING_PORT"
  }
}
