variable "project" {
  description = "The project to deploy to, if not set the default provider project is used."
  default     = ""
}

variable "region" {
  description = "Region for cloud resources"
  default     = "us-central1"
}

variable "network" {
  description = "Name of the network to create resources in"
  default     = "default"
}

variable "subnetwork" {
  description = "Name of the subnetwork to create resources in"
  default     = "default"
}

variable "name" {
  description = "Name for the forwarding rule and prefix for supporting resources"
}

variable "backends" {
  description = "List of backend instances"
  type        = "list"
}

variable "session_affinity" {
  description = "The session affinity for the backends example: NONE, CLIENT_IP. Default is `NONE`."
  default     = "NONE"
}

variable "ports" {
  description = "List of ports range to forward to backend services. Max is 5."
  type        = "list"
}

variable "check_port" {
    description = "Port to perform health checks on."
}

variable "address" {
  description = "IP address of the internal load balancer, if empty one will be assigned. Default is empty."
  default     = ""
}

variable "check_timeout" {
  description = "Backend service timeout"
  default = ""
}
