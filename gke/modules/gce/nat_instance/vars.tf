variable "project" {
  description = "Project name"
}

variable "name" {
  description = "name of the nat instance, will be appended with the zone"
}

variable "network" {
  description = "The network to deploy to"
}

variable "subnetwork" {
  description = "The subnetwork to deploy to"
}

variable "subnetwork_project" {
  default     = ""
}

variable "region" {
  description = "The region to create the nat gateway instance in."
}

variable "zones" {
  description = "Override the zone used in the `region_params` map for the region."
  default     = ""
}

variable "tags" {
  description = "Additional compute instance network tags to apply route to."
  type        = "list"
  default     = []
}

variable "route_priority" {
  description = "The priority for the Compute Engine Route"
  default = 800
}

variable "machine_type" {
  description = "The machine type for the NAT gateway instance"
  default     = "n1-standard-1"
}

variable "address" {
  description = "Give the instance an IP"
  default     = ""
}

variable "disk_image" {
  default     = "centos-cloud/centos-7"
}

variable "type" {
  default     = "n1-standard-1"
}

variable "count" {
  default     = "1"
}

variable "serviceaccount"{
  default = "" 
}

variable "gke_nat" {
  description = "Set to true if this nat will be used for a gke cluster, if enabled you need to include gke_master_ip"
  default = "false"
}

variable "gke_master_ip" {
  default = ""
}
