output "tags" {
    value = "${google_compute_firewall.firewall.source_tags}"
}
