resource "google_compute_forwarding_rule" "default" {
  project               = "${var.project}"
  name                  = "${var.name}-forwarding-rule"
  region                = "${var.region}"
  network               = "${var.network}"
  subnetwork            = "https://www.googleapis.com/compute/v1/projects/${var.project}/regions/${var.region}/subnetworks/${var.subnetwork}"
  load_balancing_scheme = "INTERNAL"
  backend_service       = "${google_compute_region_backend_service.default.self_link}"
  ip_address            = "${var.address}"
  ip_protocol           = "TCP"
  ports                 = ["${var.ports}"]
  depends_on            = ["google_compute_region_backend_service.default"]
}

resource "google_compute_region_backend_service" "default" {
  project          = "${var.project}"
  name             = "${var.name}-backend-service"
  region           = "${var.region}"
  protocol         = "TCP"
  timeout_sec      = "${var.check_timeout}"
  session_affinity = "${var.session_affinity}"
  backend          = ["${var.backends}"]
  health_checks    = ["${google_compute_health_check.default.self_link}"]
}

# Health Check with logging enabled
resource "google_compute_health_check" "default" {
  project               = "${var.project}"
  name                  = "${var.name}-health-check"
  description           = "Health check via http"

  tcp_health_check {
    port                = "${var.check_port}"
  }

  log_config {
    enable = true
  }
}
