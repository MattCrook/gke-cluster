##############################
# Internal HTTP LoadBalancer
###############################

#######################
# proxy-only subnet
######################
resource "google_compute_subnetwork" "proxy_subnet" {
  provider      = google-beta
  name          = var.proxy_subnet_name
  region        = var.region
  ip_cidr_range = var.ip_cidr_range
  network       = var.network_id
  purpose       = "INTERNAL_HTTPS_LOAD_BALANCER"
  role          = "ACTIVE"
}


resource "google_compute_forwarding_rule" "google_compute_forwarding_rule" {
  provider              = google-beta
  project               = var.project_id
  name                  = var.fw_name
  region                = var.region
  ip_protocol           = "TCP"
  load_balancing_scheme = "INTERNAL_MANAGED"
  port_range            = var.port_range
  target                = google_compute_region_target_http_proxy.default.id
  network               = var.network_id
  subnetwork            = var.subnet_id
  network_tier          = "PREMIUM"
  depends_on            = [google_compute_subnetwork.proxy_subnet]
}


resource "google_compute_region_target_http_proxy" "default" {
  provider = google-beta
  project  = var.project_id
  name     = var.http_proxy_name
  region   = var.region
  url_map  = google_compute_region_url_map.default.id
}


resource "google_compute_region_url_map" "default" {
  provider        = google-beta
  project         = var.project_id
  name            = var.url_map_name
  region          = var.region
  default_service = google_compute_region_backend_service.default.id
}


resource "google_compute_region_backend_service" "default" {
  provider              = google-beta
  project               = var.project_id
  name                  = var.backend_service_name
  region                = var.region
  protocol              = "HTTP"
  load_balancing_scheme = "INTERNAL_MANAGED"
  timeout_sec           = 10
  health_checks         = [google_compute_region_health_check.default.id]

  backend {
    group           = var.managed_instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}
