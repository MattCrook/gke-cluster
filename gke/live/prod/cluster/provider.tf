terraform {
  required_version = ">= 1.0.0"

  required_providers {
    google      = ">= 3.74.0, < 4.0.0"
    google-beta = ">= 3.74.0, < 4.0.0"
    null        = "~> 3.0.0"
    random      = "~> 3.0.0"
    vault       = "~> 2.20.0, < 3.0.0"

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.11.1"
    }
  }
}

# Use credentials or - To login run: gcloud beta auth application-default login
provider "google" {
  credentials = base64decode(var.google_account_json_base64)
  project     = var.project_id
  region      = var.region
}

provider "google-beta" {
  credentials = base64decode(var.google_account_json_base64)
  project     = var.project_id
  region      = var.region
}
