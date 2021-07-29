output "uri" {
  value = "${google_compute_instance.instance.*.self_link}"
}

output "self_link" {
  value = ["${google_compute_instance.instance.*.self_link}"]
}

output "private_ip" {
  value = "${google_compute_instance.instance.*.network_interface.0.address}"
}

output "public_ip" {
  value = "${google_compute_instance.instance.*.network_interface.0.access_config.0.assigned_nat_ip}"
}

output "name" {
  value = "${google_compute_instance.instance.*.name}"
}

output "count" {
  value = "${google_compute_instance.instance.count}"
}

output "zone" {
  value = "${google_compute_instance.instance.*.zone}"
}

output "network" {
  value = "${var.network}"
}

output "zones" {
  value = "${var.zones}"
}

output "sa_email" {
  value = "${google_service_account.router_sa.email}"
}

output "all_ips" {
    value = "${split(",", join(",", google_compute_instance.instance.*.network_interface.0.address))}"
}
