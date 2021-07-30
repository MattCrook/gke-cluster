###################
# Private Subnetwork
###################
variable "project_name" {
    description = "Name/ ID of project in GCP"
    type        = string
}
variable "private_subnetwork_name" {
    description = "The name of the resource, provided by the client when initially creating the resource"
    type        = string
}
variable "public_subnetwork_name" {
    description = "The name of the resource, provided by the client when initially creating the resource"
    type        = string
}
variable "private_subnetwork_description" {
    description = "An optional description of this resource"
    type        = string
}
variable "private_subnetwork_network" {
    description = "The network this subnet belongs to. Only networks that are in the distributed mode can have subnetworks"
    type        = string
}
variable "private_subnetwork_range" {
    description = "The range of IP addresses belonging to this subnetwork secondary range. Ranges must be unique and non-overlapping with all primary and secondary IP ranges within a network"
    type        = string
    default     = "10.2.0.0/16"
}
variable "private_subnetwork_secondary_ip_range_name" {
    description = "The name associated with this subnetwork secondary range, used when adding an alias IP range to a VM instance"
    type        = string
}
variable "private_subnetwork_secondary_ip_range" {
    description = "An array of configurations for secondary IP ranges for VM instances contained in this subnetwork"
    type        = string
}

###################
# Public Subnetwork
###################

variable "public_subnetwork_description" {
    description = "An optional description of this resource"
    type        = string
}
variable "public_subnetwork_network" {
    description = "The network this subnet belongs to. Only networks that are in the distributed mode can have subnetworks"
    type        = string
}
variable "public_subnetwork_range" {
    description = "The range of IP addresses belonging to this subnetwork secondary range. Ranges must be unique and non-overlapping with all primary and secondary IP ranges within a network"
    type        = string
    default     = "10.2.0.0/16"
}
variable "public_subnetwork_secondary_ip_range_name" {
    description = "The name associated with this subnetwork secondary range, used when adding an alias IP range to a VM instance"
    type        = string
}
variable "public_subnetwork_secondary_ip_range" {
    description = "An array of configurations for secondary IP ranges for VM instances contained in this subnetwork"
    type        = string
}

variable "region" {
    description = "Region of project"
    type        = string
    default     = "us-central1"
}

// variable "flow_logs" {
//     default = "false"
// }
