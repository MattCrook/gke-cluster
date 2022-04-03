variable "project_id" {
  description = "The project id in GCP of the project to provision resouces"
  type        = string
}

variable "disk_encryption_key" {
  description = "The self link of the encryption key that is stored in Google Cloud KMS to use to encrypt all the disks on this instance"
  type        = string
  default     = null
}

variable "network_id" {
  type        = string
  default     = "default"
}

variable "subnetwork" {
  type        = string
  default     = "default"
}

variable "subnetwork_project" {
  type        = string
  default     = "default"
}
