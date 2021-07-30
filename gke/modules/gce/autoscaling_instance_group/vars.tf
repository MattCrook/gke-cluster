variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

variable "name" {
  description = "The name to use for all the cluster resources"
  type        = string
}

variable "instance_type" {
  description = "The type of Google Compute Engine Instances to run (e.g. f1-micro)"
  type        = string
}

variable "min_replicas" {
  description = "The minimum number of Google Compute Engine Instances in the Autoscaler"
  type        = number
  default     = 2
}

variable "max_replicas" {
  description = "The maximum number of Google Compute Engine Instances in the Autoscaler"
  type        = number
  default     = 10
}


variable "ssh_keys" {
  description = "id_rsa.pub ssh keys to SSH onto the VM"
  default     = "matt.crook11@gmail.com:${file("~/.ssh/id_rsa.pub")}"
}
