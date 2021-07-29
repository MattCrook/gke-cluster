resource "google_compute_instance" "instance" {
  project       = "${var.project_name}"
  count         = "${var.count}"
  name          = "${element(var.name, count.index)}-${replace(element(var.zones, count.index), "/^(..).*-(.).*(.)-.*(.)$/", "$1$2$3$4")}-${count.index + 1}"
  zone          = "${element(var.zones, count.index)}"
  machine_type  = "${element(var.type, count.index)}"
  can_ip_forward = "${var.ipforward}"

  tags          = ["${var.tags}"]

  boot_disk {
    initialize_params {
        image       = "${element(var.disk_image, count.index)}"
        size        = "${element(var.disk_size, count.index)}"
        type        = "${element(var.disk_type, count.index)}"
    }
    auto_delete = "${element(var.disk_autodelete, count.index)}"
  }

  network_interface {
    network = "${var.network}"
    subnetwork_project = "${var.subnetwork_project}"
    subnetwork  = "${var.subnetwork}"
    address     = "${length(var.address) > 0 ? element(concat(var.address, list("")), count.index) : ""}"

    access_config {
      // Ephemeral IP
        nat_ip = "${length(var.external_ip) > 0 ? element(concat(var.external_ip, list("")), count.index) : ""}"
    }
  }

  service_account {
    email  = "${var.serviceaccount}"
    scopes = ["${concat(var.serviceaccount_scopes,var.extra_scopes)}"]
  }

  labels = "${var.labels}"

  metadata = "${merge(var.instance_metadata, map("startup-script-url", var.startup_script_url))}"

}
