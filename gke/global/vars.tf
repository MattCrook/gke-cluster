variable "project_id" {
  description = "The project id of the current project as shown in GCP"
  type        = string
}

variable "region" {
  description = "The region of the current project"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The zone of the current project"
  type        = string
  default     = "us-central1-c"
}

variable "cluster_name" {
  description = "The name to use to namespace all the resources in the cluster"
  type        = string
  default     = "gke-cluster-dev"
}

variable "encryption_key_names" {
  description = "Optional map of lowercase unprefixed name => string, empty strings are ignored."
  type        = map(string)
  default     = {}
}

# For remote state data source
variable "db_remote_state_bucket" {
  description = "The name of the Cloud Storage bucket used for the database's remote state storage"
  type        = string
  default     = "core-tf-state"
}

variable "db_remote_state_key" {
  description = "The prefix of the key in the Cloud Storage bucket used for the database's remote state storage"
  type        = string
  default     = "global/terraform.tfstate"
}

variable "enable_logging" {
  description = "If set to true, enables logging and creates a GCS bucket to store the logging files"
  type        = bool
  default     = false
}

variable "storage_class" {
    description = "The Storage Class of the new bucket"
    type        = string
    default     = "STANDARD"
}

variable bucket_name {}
variable versioning { default = "false" }
variable acl { type = "list" default = [] }
variable object_name {}
variable filename {}
variable content {}
variable content_type { default = "" }
