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


################
# SSL
###############
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
  ip_address            = google_compute_global_address.l7_global_address.address
  depends_on            = [google_compute_global_address.l7_global_address]
}

resource "google_compute_target_ssl_proxy" "ssl_target_proxy" {
  name             = var.ssl_target_proxy_name
  backend_service  = google_compute_backend_service.ssl_backend_service.id
  ssl_certificates = [google_compute_ssl_certificate.self_signed.id]
}

resource "google_compute_backend_service" "ssl_backend_service" {
  provider                        = google-beta
  project                         = var.project_id
  name                            = var.backend_service_name
  protocol                        = "SSL"
  load_balancing_scheme           = "EXTERNAL"
  timeout_sec                     = var.timeout_sec
  connection_draining_timeout_sec = var.connection_draining_timeout_sec
  security_policy                 = var.security_policy
  health_checks                   = [google_compute_health_check.ssl.id]

  backend {
    description           = "Backend for the NEG forwarding to GCE VM instance in ${var.zone}."
    balancing_mode        = var.balancing_mode
    max_rate_per_endpoint = var.max_rate_per_endpoint
    group                 = google_compute_global_network_endpoint_group.ssl_neg.id
  }

  log_config {
    enable = true
  }
}

resource "google_compute_global_network_endpoint_group" "ssl_neg" {
  provider              = google-beta
  project               = var.project_id
  name                  = var.neg_name
  description           = "Global Network Endpoint Group for ${google_compute_backend_service.ssl_backend_service.name} in ${var.zone}."
  network_endpoint_type = "INTERNET_IP_PORT"
  default_port          = var.default_port
}

resource "google_compute_global_network_endpoint" "network_endpoint" {
  project                       = var.project_id
  global_network_endpoint_group = google_compute_global_network_endpoint_group.node_04_l7_xlb_ssl_neg.name
  ip_address                    = google_compute_instance.tableau_type_2_node_webserver_04.network_interface.0.access_config.0.nat_ip
  port                          = google_compute_global_network_endpoint_group.ssl_neg.default_port
}
