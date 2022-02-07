output "tcp_fw_address" {
  value = google_compute_forwarding_rule.tcp_l4_xlb_fowarding_rule.ip_address
}
