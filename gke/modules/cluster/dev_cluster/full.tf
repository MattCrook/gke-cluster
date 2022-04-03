// resource "google_container_cluster" "cluster" {
//     cluster_ipv4_cidr           = (known after apply)
//     datapath_provider           = (known after apply)
//     default_max_pods_per_node   = (known after apply)
//     description                 = "GKE cluster for dev environment"
//     enable_binary_authorization = false
//     enable_intranode_visibility = (known after apply)
//     enable_kubernetes_alpha     = false
//     enable_l4_ilb_subsetting    = false
//     enable_legacy_abac          = false
//     enable_shielded_nodes       = true
//     enable_tpu                  = false
//     endpoint                    = (known after apply)
//     id                          = (known after apply)
//     initial_node_count          = 1
//     label_fingerprint           = (known after apply)
//     location                    = "us-central1-c"
//     logging_service             = "logging.googleapis.com/kubernetes"
//     master_version              = (known after apply)
//     min_master_version          = "latest"
//     monitoring_service          = "monitoring.googleapis.com/kubernetes"
//     name                        = "gke-dev-cluster"
//     network                     = "default"
//     networking_mode             = (known after apply)
//     node_locations              = (known after apply)
//     node_version                = (known after apply)
//     operation                   = (known after apply)
//     private_ipv6_google_access  = (known after apply)
//     project                     = "k8-cluster-project"
//     remove_default_node_pool    = true
//     resource_labels             = {
//         "env" = "dev"
//     }
//     self_link                   = (known after apply)
//     services_ipv4_cidr          = (known after apply)
//     subnetwork                  = "default"
//     tpu_ipv4_cidr_block         = (known after apply)

//     addons_config {
//         cloudrun_config {
//             disabled           = (known after apply)
//             load_balancer_type = (known after apply)
//         }

//         config_connector_config {
//             enabled = (known after apply)
//         }

//         dns_cache_config {
//             enabled = (known after apply)
//         }

//         gce_persistent_disk_csi_driver_config {
//             enabled = (known after apply)
//         }

//         horizontal_pod_autoscaling {
//             disabled = false
//         }

//         http_load_balancing {
//             disabled = false
//         }

//         istio_config {
//             auth     = "AUTH_MUTUAL_TLS"
//             disabled = false
//         }

//         kalm_config {
//             enabled = (known after apply)
//         }

//         network_policy_config {
//             disabled = (known after apply)
//         }
//     }

//     authenticator_groups_config {
//         security_group = (known after apply)
//     }

//     cluster_autoscaling {
//         autoscaling_profile = (known after apply)
//         enabled             = (known after apply)

//         auto_provisioning_defaults {
//             min_cpu_platform = (known after apply)
//             oauth_scopes     = (known after apply)
//             service_account  = (known after apply)
//         }

//         resource_limits {
//             maximum       = (known after apply)
//             minimum       = (known after apply)
//             resource_type = (known after apply)
//         }
//     }

//     cluster_telemetry {
//         type = (known after apply)
//     }

//     confidential_nodes {
//         enabled = (known after apply)
//     }

//     database_encryption {
//         key_name = (known after apply)
//         state    = (known after apply)
//     }

//     default_snat_status {
//         disabled = (known after apply)
//     }

//     identity_service_config {
//         enabled = (known after apply)
//     }

//     ip_allocation_policy {
//         cluster_ipv4_cidr_block       = (known after apply)
//         cluster_secondary_range_name  = (known after apply)
//         services_ipv4_cidr_block      = (known after apply)
//         services_secondary_range_name = (known after apply)
//     }

//     logging_config {
//         enable_components = (known after apply)
//     }

//     master_auth {
//         client_certificate     = (known after apply)
//         client_key             = (sensitive value)
//         cluster_ca_certificate = (known after apply)

//         client_certificate_config {
//             issue_client_certificate = false
//         }
//     }

//     monitoring_config {
//         enable_components = (known after apply)
//     }

//     network_policy {
//         enabled  = (known after apply)
//         provider = (known after apply)
//     }

//     node_config {
//         boot_disk_kms_key = (known after apply)
//         disk_size_gb      = (known after apply)
//         disk_type         = (known after apply)
//         guest_accelerator = (known after apply)
//         image_type        = (known after apply)
//         labels            = (known after apply)
//         local_ssd_count   = (known after apply)
//         machine_type      = (known after apply)
//         metadata          = (known after apply)
//         min_cpu_platform  = (known after apply)
//         node_group        = (known after apply)
//         oauth_scopes      = (known after apply)
//         preemptible       = (known after apply)
//         service_account   = (known after apply)
//         spot              = (known after apply)
//         tags              = (known after apply)
//         taint             = (known after apply)

//         ephemeral_storage_config {
//             local_ssd_count = (known after apply)
//         }

//         gcfs_config {
//             enabled = (known after apply)
//         }

//         kubelet_config {
//             cpu_cfs_quota        = (known after apply)
//             cpu_cfs_quota_period = (known after apply)
//             cpu_manager_policy   = (known after apply)
//         }

//         linux_node_config {
//             sysctls = (known after apply)
//         }

//         sandbox_config {
//             sandbox_type = (known after apply)
//         }

//         shielded_instance_config {
//             enable_integrity_monitoring = (known after apply)
//             enable_secure_boot          = (known after apply)
//         }

//         workload_metadata_config {
//             mode = (known after apply)
//         }
//     }

//     node_pool {
//         initial_node_count          = (known after apply)
//         instance_group_urls         = (known after apply)
//         managed_instance_group_urls = (known after apply)
//         max_pods_per_node           = (known after apply)
//         name                        = (known after apply)
//         name_prefix                 = (known after apply)
//         node_count                  = (known after apply)
//         node_locations              = (known after apply)
//         version                     = (known after apply)

//         autoscaling {
//             max_node_count = (known after apply)
//             min_node_count = (known after apply)
//         }

//         management {
//             auto_repair  = (known after apply)
//             auto_upgrade = (known after apply)
//         }

//         network_config {
//             create_pod_range    = (known after apply)
//             pod_ipv4_cidr_block = (known after apply)
//             pod_range           = (known after apply)
//         }

//         node_config {
//             boot_disk_kms_key = (known after apply)
//             disk_size_gb      = (known after apply)
//             disk_type         = (known after apply)
//             guest_accelerator = (known after apply)
//             image_type        = (known after apply)
//             labels            = (known after apply)
//             local_ssd_count   = (known after apply)
//             machine_type      = (known after apply)
//             metadata          = (known after apply)
//             min_cpu_platform  = (known after apply)
//             node_group        = (known after apply)
//             oauth_scopes      = (known after apply)
//             preemptible       = (known after apply)
//             service_account   = (known after apply)
//             spot              = (known after apply)
//             tags              = (known after apply)
//             taint             = (known after apply)

//             ephemeral_storage_config {
//                 local_ssd_count = (known after apply)
//             }

//             gcfs_config {
//                 enabled = (known after apply)
//             }

//             kubelet_config {
//                 cpu_cfs_quota        = (known after apply)
//                 cpu_cfs_quota_period = (known after apply)
//                 cpu_manager_policy   = (known after apply)
//             }

//             linux_node_config {
//                 sysctls = (known after apply)
//             }

//             sandbox_config {
//                 sandbox_type = (known after apply)
//             }

//             shielded_instance_config {
//                 enable_integrity_monitoring = (known after apply)
//                 enable_secure_boot          = (known after apply)
//             }

//             workload_metadata_config {
//                 mode = (known after apply)
//             }
//         }

//         upgrade_settings {
//             max_surge       = (known after apply)
//             max_unavailable = (known after apply)
//         }
//     }

//     notification_config {
//         pubsub {
//             enabled = (known after apply)
//             topic   = (known after apply)
//         }
//     }

//     release_channel {
//         channel = "STABLE"
//     }

//     vertical_pod_autoscaling {
//         enabled = false
//     }

//     workload_identity_config {
//         workload_pool = (known after apply)
//     }
// }







// resource "google_container_node_pool" "pool" {
//     cluster                     = "gke-dev-cluster"
//     id                          = (known after apply)
//     initial_node_count          = (known after apply)
//     instance_group_urls         = (known after apply)
//     location                    = "us-central1-c"
//     managed_instance_group_urls = (known after apply)
//     max_pods_per_node           = (known after apply)
//     name                        = "gke-dev-cluster-node-pool"
//     name_prefix                 = (known after apply)
//     node_count                  = 2
//     node_locations              = (known after apply)
//     operation                   = (known after apply)
//     project                     = "k8-cluster-project"
//     version                     = (known after apply)

//     autoscaling {
//         max_node_count = 3
//         min_node_count = 1
//     }

//     management {
//         auto_repair  = true
//         auto_upgrade = true
//     }

//     network_config {
//         create_pod_range    = (known after apply)
//         pod_ipv4_cidr_block = (known after apply)
//         pod_range           = (known after apply)
//     }

//     node_config {
//         disk_size_gb      = 50
//         disk_type         = "pd-standard"
//         guest_accelerator = (known after apply)
//         image_type        = "COS"
//         labels            = (known after apply)
//         local_ssd_count   = (known after apply)
//         machine_type      = "e2-medium"
//         metadata          = (known after apply)
//         oauth_scopes      = [
//             "https://www.googleapis.com/auth/cloud-platform",
//             "https://www.googleapis.com/auth/compute",
//             "https://www.googleapis.com/auth/devstorage.full_control",
//             "https://www.googleapis.com/auth/logging.write",
//             "https://www.googleapis.com/auth/monitoring",
//             "https://www.googleapis.com/auth/service.management.readonly",
//             "https://www.googleapis.com/auth/servicecontrol",
//             "https://www.googleapis.com/auth/trace.append",
//         ]
//         preemptible       = false
//         service_account   = (known after apply)
//         spot              = false
//         taint             = (known after apply)

//         shielded_instance_config {
//             enable_integrity_monitoring = (known after apply)
//             enable_secure_boot          = (known after apply)
//         }

//         workload_metadata_config {
//             mode = (known after apply)
//         }
//     }

//     upgrade_settings {
//         max_surge       = (known after apply)
//         max_unavailable = (known after apply)
//     }
// }
