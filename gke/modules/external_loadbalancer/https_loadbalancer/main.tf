##########################################################
# External HTTPS Load Balancer with HTTP to HTTPS Redirect
##########################################################

#######################
# Static Global Address
######################
resource "google_compute_global_address" "global_address" {
  project      = var.project_id
  name         = var.global_address_name
  description  = var.global_address_description
  address_type = "EXTERNAL"
  ip_version   = "IPV4"
}

################
# HTTPS
###############
resource "google_compute_global_forwarding_rule" "xlb_https_forwarding_rule" {
  project               = var.project_id
  name                  = var.https_fw_name
  description           = var.https_fw_description
  target                = google_compute_target_https_proxy.xlb_https_proxy.self_link
  load_balancing_scheme = "EXTERNAL"
  port_range            = 443
  ip_protocol           = "TCP"
  ip_address            = var.global_ipv4_address
  depends_on            = [var.compute_global_address]
  labels                = var.https_fw_labels
}

resource "google_compute_target_https_proxy" "xlb_https_proxy" {
  project          = var.project_id
  name             = var.https_proxy_name
  description      = var.https_proxy_description
  url_map          = google_compute_url_map.xlb_https_url_map.self_link
  ssl_certificates = var.create_self_signed_cert ? [google_compute_ssl_certificate.self_signed[0].self_link] : var.ssl_certificates
}

resource "google_compute_url_map" "xlb_https_url_map" {
  provider        = google-beta
  project         = var.project_id
  name            = var.https_url_map_name
  description     = var.https_url_map_description
  default_service = google_compute_backend_service.xlb_https_backend_service.id
}

resource "google_compute_backend_service" "xlb_https_backend_service" {
  provider                        = google-beta
  project                         = var.project_id
  name                            = var.backend_service_name
  description                     = var.backend_service_description
  protocol                        = var.protocol
  load_balancing_scheme           = "EXTERNAL"
  timeout_sec                     = 10
  connection_draining_timeout_sec = 10
  security_policy                 = var.enable_security_policy ? var.security_policy : null
  health_checks                   = var.health_checks

  backend {
    description           = var.backend_description
    balancing_mode        = var.balancing_mode
    max_rate_per_endpoint = var.max_rate_per_endpoint
    group                 = var.group
  }

  log_config {
    enable = var.enable_log_config
  }
}

########################
# HTTP to HTTPS Redirect
#######################
resource "google_compute_global_forwarding_rule" "l7_xlb_http_forwarding_rule" {
  count                 = var.enable_http ? 1 : 0
  provider              = google-beta
  project               = var.project_id
  name                  = var.http_fw_name
  description           = var.http_fw_description
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = 80
  target                = google_compute_target_http_proxy.l7_xlb_http_target_proxy[0].id
  ip_address            = var.global_ipv4_address
  labels                = var.http_fw_labels
  depends_on            = [var.compute_global_address]
}

resource "google_compute_target_http_proxy" "l7_xlb_http_target_proxy" {
  count       = var.enable_http ? 1 : 0
  project     = var.project_id
  name        = var.http_proxy_name
  description = var.http_proxy_description
  url_map     = var.enable_http && var.enable_redirect ? join("", google_compute_url_map.l7_xlb_http_redirect.*.self_link) : google_compute_url_map.xlb_https_url_map.self_link
}

resource "google_compute_url_map" "l7_xlb_http_redirect" {
  count       = var.enable_http && var.enable_redirect ? 1 : 0
  project     = var.project_id
  name        = var.http_url_map_name
  description = var.http_url_map_description


  default_url_redirect {
    https_redirect         = true
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query            = false
  }
}
