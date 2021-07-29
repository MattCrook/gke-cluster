###################
# Subnetwork
###################
variable project_name {}
variable private_subnetwork_name {}
variable public_subnetwork_name {}
variable private_subnetwork_description {}
variable private_subnetwork_network {}
variable private_subnetwork_range { default = "10.2.0.0/16" }
variable private_subnetwork_secondary_ip_range_name {}
variable private_subnetwork_secondary_ip_range {}

variable public_subnetwork_description {}
variable public_subnetwork_network {}
variable public_subnetwork_range { default = "10.2.0.0/16" }
variable public_subnetwork_secondary_ip_range_name {}
variable public_subnetwork_secondary_ip_range {}

variable "region" {
    default = "us-central1"
}

// variable "flow_logs" {
//     default = "false"
// }
