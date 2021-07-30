output "public_ip" {
  value = "${google_compute_address.example.address}"
}

output "autoscaler_self_link" {
  description = "The URI of the created resource"
  value       = "${google_compute_autoscaler.autoscaling_group.self_link}"
}

output "instance_group_manager_self_link" {
  value = "${google_compute_instance_group_manager.instance_group_manager.self_link}"
}

output "instance_group" {
  description = "The full URL of the instance group created by the manager"
  value       = "${google_compute_instance_group_manager.instance_group_manager.instance_group}"
}

output "status" {
  description = "The status of this managed instance group"
  value       = "${google_compute_instance_group_manager.instance_group_manager.status}"
}
