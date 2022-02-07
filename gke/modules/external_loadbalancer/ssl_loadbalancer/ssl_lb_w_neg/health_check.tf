resource "google_compute_health_check" "ssl" {
  project = var.project_id
  name    = "ssl-health-check"

  check_interval_sec  = var.health_check["check_interval_sec"]
  healthy_threshold   = var.health_check["healthy_threshold"]
  timeout_sec         = var.health_check["timeout_sec"]
  unhealthy_threshold = var.health_check["unhealthy_threshold"]

  ssl_health_check {
    port = "443"
  }
}
