data "google_project" "production_host" {
  project_id = var.project_id
}

data "google_project" "production_kubernetes" {
  project_id = local.kubernetes_project_id
}

resource "google_project_iam_member" "compute" {
  project = data.google_project.production_host.project_id
  role    = "roles/compute.networkUser"
  member  = "serviceAccount:${data.google_project.production_kubernetes.number}@cloudservices.gserviceaccount.com"
}

resource "google_project_iam_member" "container" {
  project = data.google_project.production_host.project_id
  role    = "roles/container.serviceAgent"
  member  = "serviceAccount:service-${data.google_project.production_kubernetes.number}@container-engine-robot.iam.gserviceaccount.com"
}

module "cluster" {
  source  = "../../../modules/prod_cluster"

  project_id                 = data.google_project.production_kubernetes.project_id
  host_project_id            = data.google_project.production_host.project_id
  name                       = "tf-uc1-gke-container-cluster"
  random_name_suffix         = true
  regional                   = true
  region                     = "us-central1"
  network                    = local.subnetworks.platform.production.infrastructure.us-central1.id
  network_project_id         = local.host_project_id
  subnetwork                 = local.network_id
  ip_range_pods              = local.subnetworks.platform.production.infrastructure.us-central1.secondary_ip_ranges[0].range_name
  ip_range_services          = local.subnetworks.platform.production.infrastructure.us-central1.secondary_ip_ranges[1].range_name
  create_service_account     = true
  enable_private_endpoint    = true
  enable_private_nodes       = true
  master_ipv4_cidr_block     = local.subnetworks.platform.production.infrastructure.us-central1.master_ipv4_cidr_block
  default_max_pods_per_node  = 110
  remove_default_node_pool   = true
  skip_provisioners          = true
  add_cluster_firewall_rules = true
  configure_ip_masq          = false
  release_channel            = "REGULAR"

  node_pools = [
    {
      name              = "webservers-01"
      min_count         = 1
      max_count         = 100
      local_ssd_count   = 0
      disk_size_gb      = 100
      disk_type         = "pd-ssd"
      image_type        = "COS_CONTAINERD"
      auto_repair       = true
      auto_upgrade      = true
      preemptible       = true
      max_pods_per_node = 110
      machine_type      = "n2-standard-8"
    },
    {
      name              = "terraform-01"
      min_count         = 1
      max_count         = 100
      local_ssd_count   = 0
      disk_size_gb      = 100
      disk_type         = "pd-ssd"
      image_type        = "COS_CONTAINERD"
      auto_repair       = true
      auto_upgrade      = true
      preemptible       = false
      max_pods_per_node = 110
      machine_type      = "c2-standard-8"
    },
  ]

  node_pools_taints = {
    all = []

    terraform-01 = [
      {
        key    = "dedicated"
        value  = "terraform"
        effect = "NO_SCHEDULE"
      },
    ]
  }


  master_authorized_networks = []

  depends_on = [
    google_project_iam_member.compute,
    google_project_iam_member.container,
  ]
}

data "google_container_cluster" "gke" {
  name     = module.cluster.name
  location = "us-central1"
  project  = data.google_project.production_kubernetes.project_id
}
