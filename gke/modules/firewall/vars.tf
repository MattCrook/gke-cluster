variable "project" {
    description = "Name/ ID of project in GCP"
    type        = string
}

variable "name"   {
    description = "Name of the resource (firewall) created"
    type        = string
}

variable "network" {
    description = "The name or self_link of the network to attach this firewall to"
    type        = string
}

variable "protocol" {
    description = "The IP protocol to which this rule applies"
    type        = string
}

variable "ports" {
    description = "An optional list of ports to which this rule applies. This field is only applicable for UDP or TCP protocol"
    type        = list(string)
    default     = []
}

variable "range" {
    description = "If source ranges are specified, the firewall will apply only to traffic that has source IP address in these ranges"
    type        = list(string)
    default     = []
}

variable "source_tags" {
    description = "If source tags are specified, the firewall will apply only to traffic with source IP that belongs to a tag listed in source tags"
    type        = list(string)
    default     = []
}

variable "target_tags" {
    description = "A list of instance tags indicating sets of instances located in the network that may make network connections as specified in allowed"
    type        = list(string)
    default     = []
}

variable "priority" {
    description = "Priority for this rule. This is an integer between 0 and 65535, both inclusive"
    default     = "1000"
}

variable "direction" {
    description = "Direction of traffic to which this firewall applies"
    default     = "INGRESS"
}
