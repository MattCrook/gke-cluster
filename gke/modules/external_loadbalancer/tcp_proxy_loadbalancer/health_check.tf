resource "google_compute_health_check" "default" {
  provider = google-beta

  name               = "tcp-proxy-health-check"
  timeout_sec        = 1
  check_interval_sec = 1

  tcp_health_check {
    port = "80"
  }
}
