variable "project_id" {
  description = "The project id in GCP of the project to provision resouces"
  type        = string
}

variable "enable_redirect" {
  description = "Set to true to enable HTTP to HTTPS redirect support in the load balancers - requires 'enable_http' be set to 'true' as well"
  type        = bool
  default     = true
}

variable "enable_http" {
  description = "Set to true to enable HTTP support - requests and traffic on port 80 through the load balancers"
  type        = bool
  default     = true
}

variable "create_self_signed_cert" {
  description = "Set to true to create a self signed TLS cert and key to use in the HTTPSURLMap. This should only be used for testing purposes or development"
  type        = bool
  default     = false
}

variable "enable_log_config" {
  description = "Set to true to enable logging on the HTTPS load balancer."
  type        = bool
  default     = false
}

variable "enable_security_policy" {
  description = "Set to true to enable cloud Armor Security Policies"
  type        = bool
  default     = false
}

variable "security_policy" {
  description = "ID of the Cloud Armor security policy to apply to the load balancer"
  type        = string
  default     = null
}

variable "zone" {
  description = "Zone in which the GCE instance resides, as well as the zone to place the NEG as target of GCLB"
  type        = string
}

variable "network" {
  description = "The network to which all network endpoints in the NEG belong"
  type        = string
}

variable "subnetwork" {
  description = "Subnetwork to which all network endpoints in the NEG belong"
  type        = string
  default     = ""
}

variable "global_ipv4_address" {
  description = "The static global IPv4 address for the load balancer"
  type        = string
}

variable "compute_global_address" {
  description = "The static global IPv4 address resource for the load balancer"
}

variable "https_fw_name" {
  description = "Human readable name of the https forwarding rule"
  type        = string
  default     = ""
}

variable "http_fw_name" {
  description = "Human readable name of the http forwarding rule (for http t https redirect)"
  type        = string
  default     = ""
}

variable "https_fw_description" {
  description = "Description to provide https forwarding rule"
  type        = string
  default     = ""
}

variable "http_fw_description" {
  description = "Description to provide http forwarding rule (for http to https redirect)"
  type        = string
  default     = "Global HTTP forwarding rule for HTTP to HTTPS redirect on port 80 to port 443 for backend NEG."
}

variable "https_fw_labels" {
  type        = map(string)
  default     = {}
}

variable "http_fw_labels" {
  type        = map(string)
  default     = {}
}

variable "https_proxy_name" {
  description = "Human readable name of the https proxy"
  type        = string
  default     = ""
}

variable "http_proxy_name" {
  description = "Human readable name of the http proxy"
  type        = string
  default     = ""
}

variable "https_proxy_description" {
  description = "Description to provide the https proxy resource"
  type        = string
  default     = ""
}

variable "http_proxy_description" {
  description = "Description to provide the http proxy resource"
  type        = string
  default     = "HTTP xlb Target Proxy for HTTP to HTTPS redirect that will force HTTPS traffic by sending traffic to backend or to HTTP to HTTPS redirect (if redirect is enabled)."
}

variable "ssl_certificates" {
  description = "SSL/TLS certificates to provide for SSL off load of HTTPS traffic"
  type        = list(string)
  default     = []
}

variable "https_url_map_name" {
  description = "Human readable name of the https url map"
  type        = string
  default     = ""
}

variable "http_url_map_name" {
  description = "Human readable name of the http url map"
  type        = string
  default     = ""
}

variable "https_url_map_description" {
  description = "Description to provide the https url map resource"
  type        = string
  default     = ""
}

variable "http_url_map_description" {
  description = "Description to provide the http url map resource"
  type        = string
  default     = "HTTP to HTTPS redirect URL map for HTTPS External Load Balancer to NEG backend."
}

variable "backend_service_name" {
  description = "Human readable name of the backend service"
  type        = string
  default     = ""
}

variable "backend_service_description" {
  description = "Description to provide the https backend service resource"
  type        = string
  default     = ""
}

variable "protocol" {
  description = "Network protocol to use. (e.g. HTTP, HTTPS, TCP, etc...)"
  type        = string
  default     = "HTTPS"
}

variable "health_checks" {
  description = "Health check to provide the backend service as readiness probe to check the backend instance"
  type        = list(string)
  default     = []
}

variable "backend_description" {
  description = "Description of backend group in backend service"
  type        = string
  default     = ""
}
