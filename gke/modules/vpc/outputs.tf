###############
# Subnetwork
###############
output "private_subnet_self_link" {
    value = "${module.subnetworks.private_subnet_self_link}"
}
output "private_subnet_address" {
    value = "${module.subnetworks.private_subnet_address}"
}

output "public_subnet_self_link" {
    value = "${module.subnetworks.public_subnet_self_link}"
}
output "public_subnet_address" {
    value = "${module.subnetworks.public_subnet_address}"
}
