output "cloud_spanner_instance_id" {
  value = "${google_spanner_instance.spanner.id}"
}

output "cloud_spanner_instance_state" {
  value = "${google_spanner_instance.spanner.state}"
}
