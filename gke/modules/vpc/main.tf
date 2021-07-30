#################
# VPC Network
##################
resource "google_compute_network" "vpc_network" {
  project                 = "${var.project}"
  name                    = "${var.network_name}"
  description             = "${var.network_description}"
  auto_create_subnetworks = false
}

##############
# Subnetworks
##############
module "subnetworks" {
    source =  "../subnetwork"

    private_subnetwork_name                    = "gke-dev-cluster-private-subnet"
    public_subnetwork_name                     = "gke-dev-cluster-public-subnet"
    project_name                               = "${var.project}"
    private_subnetwork_description             = "Private subnet for ${var.project}"
    private_subnetwork_network                 = "${google_compute_network.vpc_network.name}"
    private_subnetwork_secondary_ip_range_name = "${google_compute_network.vpc_network.name}-private-secondary-ip-range"
    private_subnetwork_secondary_ip_range      = ""
    public_subnetwork_description              = "Public subnet for gke-dev-cluster"
    public_subnetwork_network                  = "${google_compute_network.vpc_network.name}"
    public_subnetwork_secondary_ip_range_name  = "${google_compute_network.vpc_network.name}-public-secondary-ip-range"
    public_subnetwork_secondary_ip_range       = ""
}

##########################################################
# Firewall rule for the vpc network/ Allows SSH on port 22
##########################################################
module "vpc_firewall" {
  source = "../firewall"

  project       = "${var.project}"
  name          = "${var.firewall_name}"
  network       = "${google_compute_network.vpc_network.name}"
  priority      = "1000"
  direction     = "INGRESS"
  protocol      = "tcp"
  ports         = ["22"]
  source_ranges = ["0.0.0.0/0"]
  source_tags   = ["dev"]
  target_tags   = []

  allow {
    protocol = "icmp"
  }
}
