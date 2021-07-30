################
# Router
################
variable "router_name" {
    description = "Name of the google compute router"
    type        = string
}

variable "network" {
    description = "A reference to the network to which this router belongs"
    type        = string
}

variable "region" {
    description = "Region where the router resides"
    type        = string
}

variable "router_description" {
    description = "Description of the google compute router"
    type        = string
}

variable "project" {
    description = "The ID of the project in which the resource belongs"
    type        = string
}

variable "advertised_ip_ranges" {
    description = "User-specified list of individual IP ranges to advertise in custom mode. This field can only be populated if advertiseMode is CUSTOM and is advertised to all peers of the router. These IP ranges will be advertised in addition to any specified groups"
    type        = string
}

variable "router_asn" {
    description = "Local BGP Autonomous System Number (ASN). Must be an RFC6996 private ASN, either 16-bit or 32-bit. The value will be fixed for this router resource. All VPN tunnels that link to this router will have the same local ASN"
    type        = number
    default     = 64514
}

############
# Cloud NAT
############
variable compute_internal_address_name {}
variable source_subnetwork_ip_ranges_to_nat { default = "ALL_SUBNETWORKS_ALL_IP_RANGES" }
variable min_ports_per_vm { default = "64" }
variable udp_idle_timeout_sec { default = "30" }
variable icmp_idle_timeout_sec { default = "30" }
variable tcp_established_idle_timeout_sec { default = "1200" }
variable tcp_transitory_idle_timeout_sec { default = "30" }
variable log_enabled { default = true }
variable log_level { default = "ERRORS_ONLY" }

variable "count" {
    description = "Number of google compute address resources to provision"
    type        = number
    default     = 1
}
