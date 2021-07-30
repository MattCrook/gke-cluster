resource "random_id" "tag" {
  byte_length = 8
}

module "instance" {
    source = "../instance"
    project_name       = "${var.project}"
    name               = ["${var.name}"]
    count              = "${var.count}"
    zones              = ["${var.zones}"]
    type               = ["${var.type}"]
    disk_image         = ["${var.disk_image}"]
    subnetwork         = "${var.subnetwork}"
    subnetwork_project = "${var.project}"
    address            = ["${var.address}"]
    external_ip        = ["${google_compute_address.default.address}"]
    tags               = ["${var.name}-${var.zones}-${random_id.tag.hex}"]
    ipforward          = "true"
    startup_script_url = ""
    serviceaccount     = "${var.serviceaccount}"
}

resource "google_compute_route" "nat-gateway" {
  project                = "${var.project}"
  name                   = "${var.name}-${replace(var.zones, "/^(..).*-(.).*(.)-.*(.)$/", "$1$2$3$4")}-route"
  dest_range             = "0.0.0.0/0"
  network                = "${var.network}"
  next_hop_instance      = "${element(module.instance.name, 0)}"
  next_hop_instance_zone = "${var.zones}"
  tags                   = ["${concat(var.tags)}"]
  priority               = "${var.route_priority}"
}

resource "google_compute_firewall" "nat-gateway" {
  project = "${var.project}"
  name    = "allow-${var.name}-${replace(var.zones, "/^(..).*-(.).*(.)-.*(.)$/", "$1$2$3$4")}"
  network = "${var.network}"

  allow {
    protocol = "all"
  }

  source_tags = ["${var.name}-${var.zones}-${random_id.tag.hex}", "${concat(var.tags)}"]
  target_tags = ["${var.name}-${var.zones}-${random_id.tag.hex}", "${concat(var.tags)}"]
}

resource "google_compute_address" "default" {
  project = "${var.project}"
  region  = "${var.region}"
  name    = "nat-${var.name}-${replace(var.zones, "/^(..).*-(.).*(.)-.*(.)$/", "$1$2$3$4")}"
}

// Route for GKE so that traffic to the master goes through the default gateway.
// This fixes things like kubectl exec and logs
resource "google_compute_route" "gke-master-default-gw" {
  count            = "${var.gke_nat ? 1 : 0}"
  project          = "${var.project}"
  name             = "${var.name}-${replace(var.zones, "/^(..).*-(.).*(.)-.*(.)$/", "$1$2$3$4")}-gke-route"
  dest_range       = "${var.gke_master_ip}"
  network          = "${var.network}"
  next_hop_gateway = "default-internet-gateway"
  tags             = ["${var.tags}"]
  priority         = 700
}
