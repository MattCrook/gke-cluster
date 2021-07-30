variable "project" {
  description = "The project to deploy to, if not set the default provider project is used."
  type        = string
}

variable "region" {
  description = "Region for cloud resources"
  type        = string
  default     = "us-central1"
}

variable "network" {
  description = "Name of the network to create resources in"
  type        = string
  default     = "default"
}

variable "subnetwork" {
  description = "Name of the subnetwork to create resources in"
  type        = string
  default     = "default"
}

variable "name" {
  description = "Name for the forwarding rule and prefix for supporting resources"
}

variable "backends" {
  description = "List of backend instances"
  type        = list(string)
}

variable "session_affinity" {
  description = "The session affinity for the backends example: NONE, CLIENT_IP. Default is `NONE`."
  type        = string
  default     = "NONE"
}

variable "ports" {
  description = "List of ports range to forward to backend services. Max is 5."
  type        = list(string)
}

variable "check_port" {
  description = "Port to perform health checks on."
  type        = number
}

variable "address" {
  description = "IP address of the internal load balancer, if empty one will be assigned. Default is empty."
  type        = string
}

variable "check_timeout" {
  description = "Backend service timeout"
  type        = number
}
