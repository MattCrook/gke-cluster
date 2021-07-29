provider "kubernetes" {
  load_config_file = "false"

  host     = "${module.default_cluster.endpoint}"
  username = "${var.user}"
  password = "${var.password}"

  client_certificate     = "${module.cluster.client_certificate}"
  client_key             = "${module.cluster.client_key}"
  cluster_ca_certificate = "${module.cluster.certificate}"
}
