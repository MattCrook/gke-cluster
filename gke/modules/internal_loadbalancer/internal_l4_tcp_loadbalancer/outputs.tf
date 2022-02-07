output "ip_address" {
  value = "${google_compute_forwarding_rule.default.ip_address}"
}

output "uri" {
    value = "${google_compute_region_backend_service.default.self_link}"
}
