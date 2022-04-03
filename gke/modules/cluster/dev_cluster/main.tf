resource "google_container_cluster" "cluster" {
    provider                 = google-beta

    project                  = var.project
    name                     = var.cluster_name
    description              = var.cluster_description
    location                 = var.primary_zone
    resource_labels          = var.resource_labels
    node_version             = var.node_version
    cluster_ipv4_cidr        = var.cluster_ipv4_cidr
    min_master_version       = var.min_master_version
    network                  = var.network
    subnetwork               = var.subnetwork
    logging_service          = var.logging_service
    monitoring_service       = var.monitoring_service
    initial_node_count       = var.initial_node_count
    remove_default_node_pool = var.remove_default_node_pool

    release_channel {
        channel = var.release_channel
    }

    vertical_pod_autoscaling {
        enabled = var.enable_vertical_pod_autoscaling
    }

    # This has been deprecated as of GKE 1.19.
    master_auth {
        client_certificate_config {
            issue_client_certificate = false
        }
    }

    addons_config {
        horizontal_pod_autoscaling {
            disabled = !true
        }

        http_load_balancing {
            disabled = !true
        }

        istio_config {
            disabled = true
            auth     = "AUTH_MUTUAL_TLS"
        }
    }
}


resource "google_container_node_pool" "pool" {
    provider                 = google-beta

    project                  = var.project
    name                     = var.node_pool_name
    location                 = var.primary_zone
    cluster                  = google_container_cluster.cluster.name
    node_count               = var.node_count

    management {
        auto_repair  = var.auto_repair
        auto_upgrade = var.auto_upgrade
    }

    autoscaling {
        min_node_count = var.min_node_count
        max_node_count = var.max_node_count
    }

    node_config {
        machine_type    = var.machine_type
        image_type      = var.image_type
        disk_size_gb    = var.disk_size
        disk_type       = var.disk_type
        service_account = var.serviceaccount
        preemptible     = var.preemptible
        # metadata        = merge(var.metadata, map("startup-script-url", var.startup_script_url))
        # labels          = var.labels
        # tags            = [var.tags]
        oauth_scopes    = concat(var.default_oauth_scopes, var.oauth_scopes)
        # oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
        metadata = {
            disable-legacy-endpoints = "true"
            metadata_startup_script = data.template_file.startup_script.rendered
        }
    }

    lifecycle {
        ignore_changes = [initial_node_count]
    }
}
