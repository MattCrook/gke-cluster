variable "project" {
    description = "The name/ ID of project in GCP"
    type        = string
}

variable "name" {
    description = "Name of the instance group"
    type = list(string)
}

variable "backend_instances" {
    description = "List of instances in the group. They should be given as either self_link or id. When adding instances they must all be in the same network and zone as the instance group"
    type        = list(string)
}

variable "count" {
    description = "The number of instance groups user wishes to create"
    type        = number
}

variable "zones" {
    description = "The zone that this instance group should be created in"
    type        = list(string)
}

variable "network" {
    description = "The URL of the network the instance group is in. If this is different from the network where the instances are in, the creation fails"
    type        = string
}
