data "google_client_config" "default" {
  provider = google-beta
}

data "google_compute_subnetwork" "gke_subnetwork" {
  provider = google
  count    = var.add_cluster_firewall_rules ? 1 : 0
  name     = var.subnetwork
  region   = local.region
  project  = local.network_project_id
}


/******************************************
  Get available zones in region
 *****************************************/
data "google_compute_zones" "available" {
  provider = google-beta
  project  = var.project_id
  region   = local.region
}

resource "random_shuffle" "available_zones" {
  input        = data.google_compute_zones.available.names
  result_count = 3
}


/******************************************
  Get available container engine versions
 *****************************************/
data "google_container_engine_versions" "region" {
  location = local.location
  project  = var.project_id
}

# Work around to prevent a lack of zone declaration from causing regional cluster creation from erroring out due to error
# data.google_container_engine_versions.zone: Cannot determine zone: set in this resource, or set provider-level zone.
data "google_container_engine_versions" "zone" {
  location = local.zone_count == 0 ? data.google_compute_zones.available.names[0] : var.zones[0]
  project  = var.project_id
}
