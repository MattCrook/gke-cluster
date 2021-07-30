variable project_name {}
variable count {}

variable zones {
  type = list(string)
}

variable tags {
  type = list(string)
  default = []
}

variable disk_image {
  type = list(string)
  default = ["ubuntu-1804-bionic-v20181029"]
}

variable disk_size {
  type = list(string)
  default = ["100"]
}

variable disk_type {
  type = list(string)
  default = ["pd-ssd"]
}

variable disk_autodelete {
  type = list(string)
  default = ["true"]
}

variable network {}
variable subnetwork {}

variable subnetwork_project {
  default = ""
}

variable serviceaccount {
  default = ""
}

variable serviceaccount_scopes {
  type = list(string)
  default = [
    "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring.write",
    "https://www.googleapis.com/auth/devstorage.full_control",
  ]
}

variable extra_scopes {
  type = list(string)
  default = ["compute-rw"]
}

variable name {}

variable type {
  type = list(string)
  default = ["n1-standard-4"]
}

variable ipforward {
  default = "true"
}

variable startup_script_url {}

variable instance_metadata {
  type = "map"
  default = {}
}

variable region {}

variable target_tags {
  type = list(string)
  default = []
}

variable router_ssh_user {
  default = "root"
}

variable router {}
variable credentials {}
variable discovery_record_vxlan {}
variable discovery_record_scope {}

variable enable_bgp {
  default = "false"
}

variable vxlan_private_subnet {}

variable vxlan_static_ip {
  type = list(string)
  default = ["", ""]
}

variable upgrade_bucket {
  default = "device-state"
}

variable authentication_gcp_project_id {}

variable authentication_aws_access_key {
  default = ""
}

variable authentication_aws_secret_key {
  default = ""
}

variable authentication_aws_region {
  default = "us-east-2"
}

variable encryption_gcp_keyring_id {
  default = "router"
}

variable encryption_gcp_cryptokey_id {
  default = "dev"
}

variable encryption_gcp_location {
  default = "global"
}

variable encryption_aws_key_id {
  default = ""
}

variable encryption_aws_region {
  default = "us-east-2"
}

variable storage_gcp_bucket {
  default = "device-state"
}

variable storage_aws_bucket {
  default = "device-state"
}

variable storage_aws_region {
  default = "us-east-2"
}

variable registry_images_router {}
variable registry_images_bgp {}
variable registry_images_netdata {}
variable registry_images_iperf {}
variable registry_images_cadvisor {}
variable registry_images_scheduler {}
variable registry_server_address {}

variable services_vxlan {
  default = "true"
}

variable services_scope_dashboard {
  default = "false"
}

variable services_scope {
  default = "true"
}

variable services_netdata {
  default = "true"
}

variable services_cadvisor {
  default = "false"
}

variable services_bgp {
  default = "true"
}

variable services_ipsla {
  default = "false"
}

variable services_hostapd {
  default = "false"
}

variable services_prometheus {
  default = "false"
}

variable services_slack {
  default = "true"
}

variable services_nat {
  default = "false"
}

variable services_configs_bgp_memory {
  default = "128m"
}

variable services_configs_bgp_cpus {
  default = "2"
}

variable services_configs_bgp_asn {
  default = "65520"
}

variable services_configs_bgp_redistribute {
  type = list(string)

  default = []
}

variable services_configs_bgp_accepted_community_strings {
  default = ["1:1"]
}

variable services_configs_bgp_rejected_community_strings {
  type = list(string)

  default = []
}

variable services_configs_bgp_accepted_prefix {
  type = list(string)
}

variable services_configs_bgp_rejected_prefix {
  type = list(string)

  default = []
}

variable services_configs_api_encryptedcredspath {
  default = "devices/configuration/global-config/creds.enc"
}

variable services_configs_nat_interface {
  default = ""
}

variable services_configs_routes_static {
  type = list(string)
  default = []
}

variable services_configs_ha_routes {
  default = ""
}

variable services_configs_routes_bgp {
  type = list(string)
  default = []
}

variable migration {
  default = "false"
}

variable token {}

variable services {
  default = "false"
}

variable services_configs_slack_webhook {
  default = ""
}

variable services_configs_slack_channel {}

variable services_configs_router_memory {
  default = "4g"
}

variable services_configs_router_memory_swap {
  default = "6g"
}

variable services_configs_router_memory_reservation {
  default = "2g"
}

variable services_configs_router_cpus {
  default = "2"
}

variable services_configs_scheduler_memory {
  default = "128m"
}

variable services_configs_scheduler_cpus {
  default = "2"
}

variable services_configs_snmp_rocommunity {
  default = ""
}

variable vxlan_environment {}

variable services_configs_loadbalancer {
  default = ""
}

variable services_loadbalancer {
  default = "false"
}

variable services_configs_nat_rules {
  default = ""
}

variable services_configs_scheduler_memory_swap {
  default = "256m"
}

variable services_configs_scheduler_memory_reservation {
  default = "128m"
}

variable services_teleport {
  default = "true"
}

variable test_skip_validation_test {
  default = "false"
}

variable services_configs_bgp {
  default = ""
}

variable services_configs_routes {
  default = ""
}

variable bgp_advertise_routes {
  type = list(string)

  default = []
}

variable advertised_community_strings {
  type = list(string)

  default = []
}

variable ssh_private_ip {
  default = "false"
}

variable content_type {
  default = ""
}

variable static_routes {
  type = list(string)

  default = []
}

variable services_configs_hostapd {
  default = ""
}

variable bgp_prefix_list {
  type = list(string)
  default = []
}

variable bgp_community_strings {
  type = list(string)

  default = []
}

variable backplane {
  default = "false"
}

variable gcp_advertise_routes {
  type = list(string)
  default = []
}

variable advertise_primary_ip {
  default = "true"
}

variable primary_interface_advertisement {
  default = ""
}

variable registry_images {
  default = ""
}

variable service_configs_scope_proxy {
  default = "false"
}

variable router_version {
  default = ""
}

variable set_mss {
  default = "1300"
}

variable host_tags {
  default = ""
}

variable business {}

variable high_availability {
  default = "true"
}

variable kubernetes_peer {}
variable gcp_private_bridge {}
variable serial_number {}
variable services_configs_ipsla {}
