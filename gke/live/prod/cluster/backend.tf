# Using Terraform Cloud - Workspace
// terraform {
//   backend "remote" {
//     hostname     = "app.terraform.io"
//     organization = ""

//     workspaces {
//       name = ""
//     }
//   }
// }

# Using Google Cloud Storage Bucket
// terraform {
//     backend "gcs" {
//         bucket      = "core-tf-state"
//         prefix      = "global/terraform.tfstate"
//         # credentials = "./credentials.json"
//     }
// }
