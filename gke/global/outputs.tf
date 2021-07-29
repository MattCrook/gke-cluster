output "tf_state_bucket_self_link" {
  value = "${google_storage_bucket.terraform_state.self_link}"
}

output "state_bucket_url" {
  description = "The created storage bucket"
  value       = "${google_storage_bucket.tf_state.url}"
}

output "logging_bucket_self_link" {
  description = "The created storage bucket self link"
  value       = "${google_storage_bucket.logging_bucket.self_link}"
}

output "logging_bucket_url" {
  description = "The created storage bucket self link"
  value       = "${google_storage_bucket.logging_bucket.url}"
}

output "tf-bucket-acl" {
    value = "${google_storage_bucket_acl.tf-bucket-acl.role_entity}"
}

output "logging-bucket-acl" {
    value = "${google_storage_bucket_acl.logging-bucket-acl.role_entity}"
}
