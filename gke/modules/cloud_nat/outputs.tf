output "nat_name" {
  value = "${google_compute_router_nat.nat.name}"
}

output "nat_id" {
  value = "${google_compute_router_nat.nat.id}"
}

output "nat_dev" {
  value = "${google_compute_address.address.*.address}"
}

output "router_self_link" {
 value = "${google_compute_router.router.self_link}"
}
