variable "project" {
  description = "The project id of the current project as shown in GCP"
  type        = string
}

variable "account_id" {
  description = "The Service Account ID /The Service Account name displayed in GCP"
  type        = string
}

variable "display_name" {
  description = "The Service Account name displayed in GCP"
  type        = string
}

variable "service_account_description" {
  description = "Service account for k8-cluster-poject in project"
  type        = string
}
