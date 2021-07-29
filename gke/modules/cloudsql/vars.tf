variable project_name {}
variable name {}
variable database_version {}
variable region {}
variable instance_type { default = "" }
variable disk_resize { default = "true" }
variable authorize_networks { type = "list" default = [] }
variable binary_log { default = "true" }
variable backup_enabled {}
variable backup_time { default = "" }
variable require_ssl { default = "false" }
variable database_flags { type = "list" default = [] }
variable disk_size { default = "" }
variable zone { default = "" }

#################
# CloudSQL User
#################
variable user {}
# variable master_instance {}
variable host { default = "%" }
variable password {}
