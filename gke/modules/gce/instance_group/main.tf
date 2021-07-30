# Creates a group of dissimilar Compute Engine virtual machine instances

resource "google_compute_instance_group" "group" {
    project   = "${var.project}"
    count     = "${var.count}"
    name      = "${element(var.name, count.index)}-${replace(element(var.zones, count.index), "/^(..).*-(.).*(.)-.*(.)$/", "$1$2$3$4")}-instance-group"
    instances = ["${element(var.backend_instances, count.index)}"]
    zone      = "${element(var.zones, count.index)}"
    # optional
    network   = "${var.network}"
}

resource "google_compute_http_health_check" "compute_health_check" {
  name                 = "${var.cluster_name}-health-check"
  request_path         = "/"
  check_interval_sec   = 30
  timeout_sec          = 3
  healthy_threshold    = 2
  unhealthy_threshold  = 2
  port                 = "${var.server_port}"
}


resource "google_compute_firewall" "ingress" {
  name    = "${google_compute_instance_group.group.name}-firewall-instance"
  network = "default"

  source_ranges = locals.all_ips

  allow {
    protocol = locals.tcp_protocol
    ports    = ["${var.server_port}"]
  }
}

resource "google_compute_health_check" "autohealing" {
  name                = "autohealing-health-check"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10

  http_health_check {
    request_path = "/healthz"
    port         = 80
  }
}
