
resource "google_service_account" "service_account" {
  account_id   = var.compute_instance_serviceaccount.account_id
  display_name = var.compute_instance_serviceaccount.display_name
  description  = var.compute_instance_serviceaccount.description
}
