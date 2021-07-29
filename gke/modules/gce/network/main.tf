variable project_name   {}
variable name           {}
variable description    { default = "" }
variable auto_create_subnets    { default = "false" }

resource "google_compute_network" "network" {
  project                 = "${var.project_name}"
  name                    = "${var.name}"
  description             = "${var.description}"
  auto_create_subnetworks = "${var.auto_create_subnets}"
}
