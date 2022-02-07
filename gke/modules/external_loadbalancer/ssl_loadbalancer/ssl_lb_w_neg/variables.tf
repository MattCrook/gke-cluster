variable "project_id" {
  description = "The project id in GCP of the project to provision resouces"
  type        = string
}

variable "enable_ipv6" {
  description = "Set to true to enable IPV6 address advertising"
  type        = bool
  default     = false
}

variable "balancing_mode" {
  type        = string
  default     = "RATE"
}

variable "max_rate_per_endpoint" {
  type        = number
  default     = 1000
}
