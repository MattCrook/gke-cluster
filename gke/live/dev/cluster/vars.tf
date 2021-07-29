variable "project" {
  description = "Name of GCP project"
  type        = string
  default     = "k8-cluster-project"
}

variable "user" {
  description = "The username to use for HTTP basic authentication when accessing the Kubernetes master endpoint."
  type        = string
  default     = "root"
}

variable "network" {
  description = "The name or self_link of the Google Compute Engine network to which the cluster is connected"
  type        = string
  defualt     = "default"
}

variable "subnetwork" {
  description = "GCE subnetwork (is the default subnetwork for us-central1 right now)"
  type        = string
  defualt     = "10.128.0.0/20"
}

variable "primary_zone" {
  description = "The location (region or zone) in which the cluster master will be created"
  type        = string
  default     = "us-central1-c"
}

variable "gce_storage_disk_name" {
  description = "Name of the resource. Provided by the client when the resource is created"
  type        = string
  default     = "gke-dev-cluster-storage-disk"
}

variable "gce_storage_disk_type" {
  description = "URL of the disk type resource describing which disk type to use to create the disk. Provide this when creating the disk"
  type        = string
  default     = "pd-ssd"
}

variable "resource_labels" {
  description = "The GCE resource labels (a map of key/value pairs) to be applied to the cluster"
  default = {
    "env" = "dev"
  }
}
