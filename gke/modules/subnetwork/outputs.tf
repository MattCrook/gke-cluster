####################
# Private Subnetwork
###################
output "private_subnet_self_link" {
    value = "${google_compute_subnetwork.private-subnetwork.self_link}"
}
output "private_subnet_address" {
    value = "${google_compute_subnetwork.private-subnetwork.ip_cidr_range}"
}

####################
# Public Subnetwork
###################
output "public_subnet_self_link" {
    value = "${google_compute_subnetwork.public-subnetwork.self_link}"
}
output "public_subnet_address" {
    value = "${google_compute_subnetwork.public-subnetwork.ip_cidr_range}"
}
