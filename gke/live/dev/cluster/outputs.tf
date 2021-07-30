#################
# GKE Cluster
################
output "cluster_self_link" {
    description = "The server-defined URL for the resource"
    value       = "${module.cluster.cluster_self_link}"
}

output "name" {
    value = "${module.cluster.name}"
}

output "project" {
    value = "${module.cluster.project}"
}

output "endpoint" {
    description = "The IP address of this cluster's Kubernetes master"
    value       = "${module.cluster.endpoint}"
}

output "services_ipv4_cidr" {
    description = "The IP address range of the Kubernetes services in this cluster, in CIDR notation (e.g. 1.2.3.4/29). Service addresses are typically put in the last /16 from the container CIDR"
    value       = "${module.cluster.services_ipv4_cidr}"
}

output "tpu_ipv4_cidr_block" {
    value = "${module.cluster.tpu_ipv4_cidr_block}"
}

output "certificate" {
    value       = "${module.cluster.certificate}"
    sensitive   = true
}

output "client_certificate" {
    value     = "${module.cluster.client_certificate}"
    sensitive = true
}

output "client_key" {
    value     = "${module.cluster.client_key}"
    sensitive = true
}

output "master_version" {
    value = "${module.cluster.master_version}"
}

##########################
# Node pool instance group
##########################
output "instance_group_urls" {
    description = "The resource URLs of the managed instance groups associated with this node pool"
    value       = "${module.cluster.instance_group_urls}"
}


####################
# Service Account
###################
output "service_account_id" {
    description = "An identifier for the resource"
    value       = "${module.dev_cluster_sa.service_account_id}"
}

output "service_account_email" {
    description = "The email for the service account created"
    value       = "${module.dev_cluster_sa.service_account_email}"
}

output "service_account_unique_id" {
    value = "${module.dev_cluster_sa.service_account_unique_id}"
}

##########################
# GCE Persistant Disk
#########################
output "creation_timestamp" {
    description = "Creation timestamp in RFC3339 text format"
    value       = "${google_compute_disk.gce_persistant_disk.creation_timestamp}"
}

output "gce_storage_disk_self_link" {
    description = "The URI of the created resource"
    value       = "${google_compute_disk.gce_persistant_disk.self_link}"
}

output "gce_storage_disk_name" {
    description = "The name of the storagee disk"
    value       = "${google_compute_disk.gce_persistant_disk.name}"
}
