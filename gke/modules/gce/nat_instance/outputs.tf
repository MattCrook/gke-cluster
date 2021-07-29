output "gateway_ip" {
  description = "The internal IP address of the NAT gateway instance."
  value       = "${module.instance.private_ip}"
}

output "external_ip" {
  description = "The external IP address of the NAT gateway instance."
  value       = "${google_compute_address.default.address}"
}
