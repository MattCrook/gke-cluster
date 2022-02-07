# Legacy Target Pool health check
resource "google_compute_http_health_check" "legacy_tcp" {
  project             = var.project_id
  name                = "tcp-target-pool-health-check"
  description         = "Legacy TCP health check for target pool."
  port                = 80

  check_interval_sec  = var.health_check["check_interval_sec"]
  healthy_threshold   = var.health_check["healthy_threshold"]
  timeout_sec         = var.health_check["timeout_sec"]
  unhealthy_threshold = var.health_check["unhealthy_threshold"]
}
