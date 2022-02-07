################
# SSL
###############
resource "google_compute_global_address" "global_address" {
  project      = var.project_id
  name         = var.global_address_name
  description  = "Static External facing IPv4 IP address that will accept SSL traffic on port 443."
  address_type = "EXTERNAL"
  ip_version   = "IPV4"
}

resource "google_compute_global_address" "global_address_ipv6" {
  count        = var.enable_ipv6 ? 1 : 0
  project      = var.project_id
  name         = var.global_address_name
  description  = "Static External facing IPv6 IP address that will accept SSL traffic."
  address_type = "EXTERNAL"
  ip_version   = "IPV6"
}


resource "google_compute_global_forwarding_rule" "ssl_forwarding_rule" {
  provider              = google-beta
  project               = var.project_id
  name                  = var.fw_name
  description           = var.fw_description
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = 443
  target                = google_compute_target_ssl_proxy.ssl_target_proxy.self_link
  labels                = var.fw_labels
  ip_address            = google_compute_global_address.global_address.address
  depends_on            = [google_compute_global_address.global_address]
}

resource "google_compute_target_ssl_proxy" "ssl_target_proxy" {
  name             = var.ssl_target_proxy_name
  backend_service  = google_compute_backend_service.ssl_backend_service.id
  ssl_certificates = [google_compute_ssl_certificate.self_signed.self_link]
}

resource "google_compute_backend_service" "ssl_backend_service" {
  provider                        = google-beta
  project                         = var.project_id
  name                            = var.backend_service_name
  protocol                        = "SSL"
  load_balancing_scheme           = "EXTERNAL"
  port_name                       = var.port_name
  timeout_sec                     = var.timeout_sec
  connection_draining_timeout_sec = var.connection_draining_timeout_sec
  security_policy                 = var.security_policy
  health_checks                   = [google_compute_health_check.ssl.id]

  backend {
    description     = "Backend for the SSL Passthrough forwarding to Webserver instance in ${var.zone}."
    balancing_mode  = "UTILIZATION"
    max_utilization = 1.0
    capacity_scaler = 1.0
    group           = google_compute_instance_group.region_instance_group.id
  }

  log_config {
    enable = true
  }
}
