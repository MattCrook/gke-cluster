variable "project" {
  description = "The ID of the project in GCP"
  type        = string
}

variable "regional_config" {
  description = " The name of the instance's configuration (similar but not quite the same as a region) which defines the geographic placement and replication of your databases in this instance"
  type        = string
  default     = "regional-us-central1"
}
variable "gsi_display_name" {
  description = "The descriptive name for this instance as it appears in UIs"
  type        = string
  default     = ""
}
variable "spanner_num_nodes" {
  description = "The number of nodes allocated to this instance"
  type        = number
  default     = 2
}
