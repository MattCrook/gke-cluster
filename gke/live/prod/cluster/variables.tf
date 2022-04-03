variable "google_account_json_base64" {
  type      = string
  sensitive = true
}

variable "cluster_group" {
  type        = string
  default     = ""
  description = "What is the group this cluster belongs to"
}

variable "project_id" {
  description = "The project id in GCP of the project to provision resouces"
  type        = string
  default     = ""
}
