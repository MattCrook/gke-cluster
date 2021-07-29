variable project_name       {}
variable count              {}
variable zones              { type = "list" }
variable tags               { type = "list" default = [] }
variable disk_image         { type = "list" default = [""] }
variable disk_size          { type = "list" default = ["10"] }
variable disk_type          { type = "list" default = ["pd-standard"] }
variable disk_autodelete    { type = "list" default = ["true"] }
variable network            { default = "" }
variable subnetwork         { default = "" }
variable subnetwork_project { default = ""}
variable address            { type = "list" default = [] }
variable external_ip             { type = "list" default = [] }
variable serviceaccount     { default = "" }
variable serviceaccount_scopes { type = "list" default = [
"https://www.googleapis.com/auth/compute",
"https://www.googleapis.com/auth/logging.write",
"https://www.googleapis.com/auth/monitoring.write",
"https://www.googleapis.com/auth/devstorage.full_control"
] 
}
variable extra_scopes       { type = "list" default = [] }
variable name               { type = "list" }
variable type               { type = "list" }
variable ipforward          { default = "false" }
variable startup_script_url { default = "gs://cbsi-ops/instance-startup-scripts/null" }
variable "instance_metadata" {
  type = "map"
  default = {}
}
variable "labels" {
  type = "map"
  default = {}
}
