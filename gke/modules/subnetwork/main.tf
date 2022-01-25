resource "google_compute_subnetwork" "private-subnetwork" {
    name                     = var.private_subnetwork_name
    project                  = var.project_name
    description              = var.private_subnetwork_description
    region                   = var.region
    network                  = var.private_subnetwork_network
    ip_cidr_range            = var.private_subnetwork_range
    private_ip_google_access = "true"
    depends_on               = var.private_subnetwork_network
    # purpose                   = "INTERNAL_HTTPS_LOAD_BALANCER"
    # enable_flow_logs         = var.flow_logs
    log_config {
        aggregation_interval = "INTERVAL_10_MIN"
        flow_sampling        = 0.5
        metadata             = "INCLUDE_ALL_METADATA"
    }

    secondary_ip_range {
        range_name    = var.private_subnetwork_secondary_ip_range_name
        ip_cidr_range = var.private_subnetwork_secondary_ip_range
    }
}

resource "google_compute_subnetwork" "public-subnetwork" {
    name                     = var.public_subnetwork_name
    project                  = var.project_name
    description              = var.public_subnetwork_description
    region                   = var.region
    network                  = var.public_subnetwork_network
    ip_cidr_range            = var.public_subnetwork_range
    private_ip_google_access = "false"
    depends_on               = var.public_subnetwork_network
    # enable_flow_logs         = var.flow_logs
    log_config {
        aggregation_interval = "INTERVAL_10_MIN"
        flow_sampling        = 0.5
        metadata             = "INCLUDE_ALL_METADATA"
    }

    secondary_ip_range {
        range_name    = var.public_subnetwork_secondary_ip_range_name
        ip_cidr_range = var.public_subnetwork_secondary_ip_range
    }
}
