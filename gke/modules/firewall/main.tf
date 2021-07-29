resource "google_compute_firewall" "firewall" {
    project   = "${var.project}"
    name      = "${var.name}"
    network   = "${var.network}"
    priority  = "${var.priority}"
    direction = "${var.direction}"

    allow {
        protocol = "${var.protocol}"
        ports    = ["${var.ports}"]
    }

    source_ranges = ["${var.range}"]

    source_tags  = ["${var.source_tags}"]

    target_tags  = ["${var.target_tags}"]
}
