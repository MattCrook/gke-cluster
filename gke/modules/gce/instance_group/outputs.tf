output "uri" {
    description = "The self link of each of the  instance groups"
    value       = "${google_compute_instance_group.group.*.self_link}"
}

output "name" {
    description = "The name of each instance group"
    value       = "${google_compute_instance_group.group.*.name}"
}
