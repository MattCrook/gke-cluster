locals {
  billing_account = "billing-account-number"

  host_project_id       = "project id of network cluster is in"
  kubernetes_project_id = "project id of project cluster is in"
  network_project_id    = "project id of network cluster is in"
  network_id            = "network id of the network cluster is in"

  subnetworks = {
    platform = {
      production = {
        infrastructure = {
          us-central1 = {
            id                     = "network id of network"
            ip_cidr_range          = ""
            master_ipv4_cidr_block = ""
            secondary_ip_ranges = [
              {
                range_name    = "terraform-pods"
                ip_cidr_range = ""
              },
              {
                range_name    = "terraform-services"
                ip_cidr_range = ""
              },
            ]
          }
          us-east1 = null
        }
      }
    }
  }
}
