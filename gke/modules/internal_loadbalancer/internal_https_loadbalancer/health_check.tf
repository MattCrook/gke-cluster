resource "google_compute_region_health_check" "default" {
  name   = "l7-ilb-hc"
  region = var.region

  http_health_check {
    port_specification = "USE_SERVING_PORT"
  }
}
