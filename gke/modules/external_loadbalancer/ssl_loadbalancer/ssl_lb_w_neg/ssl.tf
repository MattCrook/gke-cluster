############################################################
# Self Signed Cert (for testing purposes)
# To enable, set variable 'create_self_signed_cert' to true
############################################################
resource "tls_private_key" "self_signed" {
  count     = var.create_self_signed_cert ? 1 : 0

  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "self_signed" {
  count     = var.create_self_signed_cert ? 1 : 0

  key_algorithm         = tls_private_key.self_signed[0].algorithm
  private_key_pem       = tls_private_key.self_signed[0].private_key_pem
  validity_period_hours = 12
  early_renewal_hours   = 3

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]

  dns_names = ["example.com"]

  subject {
    common_name  = "example.com"
    organization = "ACME Examples, Inc"
  }
}

resource "google_compute_ssl_certificate" "self_signed" {
  count       = var.create_self_signed_cert ? 1 : 0

  project     = var.project_id
  name        = "default-self-signed-cert"
  private_key = tls_private_key.self_signed[0].private_key_pem
  certificate = tls_self_signed_cert.self_signed[0].cert_pem
}
