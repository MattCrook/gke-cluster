terraform {
    required_version = ">= 0.12"
}

provider "google" {
    project     = var.project
    region      = var.region
}

provider "google-beta" {
  project     = var.project
  region      = var.region
}

resource "random_string" "password" {
    length = 16
    special = true
}

module "dev_cluster_sa" {
    source                       = "../../../modules/seviceaccount"

    account_id                   = "gke-dev-cluster-sa"
    display_name                 = "${var.project}-gke-dev-cluster-sa"
    project                      = var.project
    service_account_description  = "gke-dev-cluster default GKE cluster Service Account"
}

module "cluster" {
    source = "../../../modules/cluster"

    cluster_name                    = "gke-dev-cluster"
    project                         = var.project
    primary_zone                    = var.primary_zone
    cluster_description             = "GKE cluster for dev environment"
    initial_node_count              = 1
    min_master_version              = "latest"
    # additional_zones                = [var.additional_zones]
    # node_version                    = var.node_version
    # cluster_ipv4_cidr               = "10.0.0.0/8"
    network                         = var.network
    subnetwork                      = var.subnetwork
    logging_service                 = "logging.googleapis.com/kubernetes"
    monitoring_service              = "monitoring.googleapis.com/kubernetes"
    release_channel                 = "STABLE"
    enable_vertical_pod_autoscaling = false
    user                            = "${var.user}"
    password                        = "${random_string.password.result}"
    node_pool_name                  = "gke-dev-cluster-node-pool"
    node_count                      = 2
    auto_repair                     = true
    auto_upgrade                    = true
    min_node_count                  = 1
    max_node_count                  = 3
    machine_type                    = "e2-medium"
    disk_size                       = 50
    disk_type                       = "pd-standard"
    image_type                      = "COS"
    serviceaccount                 = "${module.dev_cluster_sa.service_account_email}"
    preemptible                     = false
    # tags                            = [""]
    resource_labels                 = "${var.resource_labels}"
    # labels                          = []
}

resource "google_compute_disk" "gce_persistant_disk" {
    project = var.project
    name    = var.gce_storage_disk_name
    type    = var.gce_storage_disk_type
    zone    = var.primary_zone
    size    = 10

    labels = {
        environment = "dev"
    }

    physical_block_size_bytes = 4096
}

resource "local_file" "password" {
   content         = random_string.password.result
   filename        = "password.pem"
   file_permission = 0400
}

resource "local_file" "cluster_ca_certificate" {
   content         = "${module.cluster.certificate}"
   filename        = "cluster_ca_certificate.pem"
   file_permission = 0400
}

resource "local_file" "client_certificate" {
   content         = "${module.cluster.client_certificate}"
   filename        = "client_certificate.pem"
   file_permission = 0400
}
