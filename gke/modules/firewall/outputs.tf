output "tags" {
    value = "${google_compute_firewall.firewall.source_tags}"
}

output "firewall_self_link" {
    value = "${google_compute_firewall.firewall.self_link}"
}
