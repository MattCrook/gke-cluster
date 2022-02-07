############################################
# Internal HTTPS LoadBalancer With Redirect
############################################

#######################
# Proxy-only subnet
######################
resource "google_compute_subnetwork" "proxy_subnet" {
  provider      = google-beta
  project      = var.project_id
  name          = var.proxy_subnet_name
  region        = var.region
  ip_cidr_range = var.ip_cidr_range
  network       = var.network_id
  purpose       = "INTERNAL_HTTPS_LOAD_BALANCER"
  role          = "ACTIVE"
}

###########################
# Reserved internal address
###########################
resource "google_compute_address" "default" {
  provider     = google-beta
  project      = var.project_id
  name         = var.internal_reserved_address_name
  subnetwork   = var.subnetwork
  address_type = "INTERNAL"
  region       = var.region
  purpose      = "SHARED_LOADBALANCER_VIP"
  address      = var.predetermined_reserved_address ? var.reserved_address : null
}


######################
# Internal HTTPS
######################
resource "google_compute_forwarding_rule" "default" {
  project               = var.project_id
  name                  = var.https_fw_name
  region                = var.region
  ip_protocol           = "TCP"
  ip_address            = google_compute_address.default.id
  load_balancing_scheme = "INTERNAL_MANAGED"
  port_range            = "443"
  target                = google_compute_region_target_https_proxy.default.id
  network               = var.network_id
  subnetwork            = var.subnetwork
  network_tier          = "PREMIUM"
  depends_on            = [google_compute_subnetwork.proxy_subnet]
}

resource "google_compute_region_target_https_proxy" "default" {
  project          = var.project_id
  name             = var.https_proxy_name
  region           = var.region
  url_map          = google_compute_region_url_map.https_lb.id
  ssl_certificates = [google_compute_region_ssl_certificate.self_signed.self_link]
}

resource "google_compute_url_map" "https_lb" {
  provider        = google-beta
  project         = var.project_id
  name            = var.https_url_map_name
  description     = var.https_url_map_description
  default_service = google_compute_backend_service.ilb_https_backend_service.id
}

resource "google_compute_backend_service" "xlb_https_backend_service" {
  provider                        = google-beta
  project                         = var.project_id
  name                            = var.backend_service_name
  description                     = var.backend_service_description
  protocol                        = "HTTP"
  load_balancing_scheme           = "INTERNAL_MANAGED"
  port_name                       = var.port_name
  timeout_sec                     = 10
  connection_draining_timeout_sec = 10
  security_policy                 = var.enable_security_policy ? var.security_policy : null
  health_checks                   = [google_compute_region_health_check.default.id]

  backend {
    description           = var.backend_description
    balancing_mode        = var.balancing_mode
    max_rate_per_endpoint = var.max_rate_per_endpoint
    group                 = var.managed_instance_group
  }

  log_config {
    enable = var.enable_log_config
  }
}


##############################
# HTTP-to-HTTPS redirect
##############################
resource "google_compute_forwarding_rule" "redirect" {
  project               = var.project_id
  name                  = "l7-ilb-redirect"
  region                = var.region
  ip_protocol           = "TCP"
  ip_address            = google_compute_address.default.id
  load_balancing_scheme = "INTERNAL_MANAGED"
  port_range            = "80"
  target                = google_compute_region_target_http_proxy.default.id
  network               = var.network_id
  subnetwork            = var.subnetwork
  network_tier          = "PREMIUM"
}

resource "google_compute_region_target_http_proxy" "default" {
  project = var.project_id
  name    = var.http_proxy_name
  region  = var.region
  url_map = google_compute_region_url_map.redirect.id
}

resource "google_compute_region_url_map" "redirect" {
  project         = var.project_id
  name            = var.redirect_url_map_name
  region          = var.region
  default_service = google_compute_region_backend_service.default.id

  host_rule {
    hosts        = ["*"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = google_compute_region_backend_service.default.id

    path_rule {
      paths = ["/"]

      url_redirect {
        https_redirect         = true
        host_redirect          = "${google_compute_address.default.address}:443"
        redirect_response_code = "PERMANENT_REDIRECT"
        strip_query            = true
      }
    }
  }
}
