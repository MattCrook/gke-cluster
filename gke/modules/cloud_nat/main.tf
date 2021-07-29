resource "google_compute_router" "router" {
    name        = "${var.router_name}"
    project     = "${var.project}"
    network     = "${var.network}" # should be google_compute_network.net.id
    region      = "${var.region}" # should be google_compute_subnetwork.subnet.region
    description = "${var.router_description}"

    bgp {
        asn               = "${var.router_asn}"
        advertise_mode    = "${length(var.advertised_ip_ranges) > 0 ? "CUSTOM" : "DEFAULT"}"

        advertised_ip_ranges {
            range = "${var.advertised_ip_ranges}"
        }
    }
}

resource "google_compute_address" "address" {
  project = "${var.project}"
  count   = "${var.count}"
  name    = "${var.compute_internal_address_name}-${replace(var.region, "/^(..).*-(.).*(.)$/", "$1$2$3")}-${count.index}"
  region  = "${var.region}" # should be google_compute_subnetwork.subnet.region
}

resource "google_compute_router_nat" "nat" {
  project = "${var.project}"
  name    = "${var.compute_internal_address_name}-${replace(var.region, "/^(..).*-(.).*(.)$/", "$1$2$3")}"
  region  = "${google_compute_router.router.region}"
  router  = "${google_compute_router.router.name}"

  # nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ip_allocate_option             = "AUTO_ONLY"
  nat_ips                            = ["${google_compute_address.address.*.self_link}"]
  source_subnetwork_ip_ranges_to_nat = "${var.source_subnetwork_ip_ranges_to_nat}"

  min_ports_per_vm                 = "${var.min_ports_per_vm}"
  udp_idle_timeout_sec             = "${var.udp_idle_timeout_sec}"
  icmp_idle_timeout_sec            = "${var.icmp_idle_timeout_sec}"
  tcp_established_idle_timeout_sec = "${var.tcp_established_idle_timeout_sec}"
  tcp_transitory_idle_timeout_sec  = "${var.tcp_transitory_idle_timeout_sec}"

  log_config {
    filter = "${var.log_level}"
    enable = "${var.log_enabled}"
  }
}
