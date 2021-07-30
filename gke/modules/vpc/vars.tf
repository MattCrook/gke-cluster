#####################
# Compute Network
######################

variable "network_description" {
    description = "Description of the google compute network"
    type        = string
}

variable "network_name" {
    description = "Name of the google compute network"
    type        = string
}


variable "project_name" {
    description = "Project name/ ID in GCP"
    type        = string
}

variable "network_name" {
    description = "Name of the VPC network network created by google_compute_network"
    type        = string
}
