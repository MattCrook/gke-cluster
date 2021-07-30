locals {
  http_port    = 80
  any_port     = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
}

resource "google_compute_address" "compute_address" {
    name = "${var.name}-address"
}


resource "google_compute_instance_template" "instance_template" {
  name           = "${google_compute_instance_group_manager.instance_group_manager.name}-instance-template"
  description    = "The template used to create VM instances"
  machine_type   = "${var.instance_type}"

  boot_disk {
    initialize_params {
      image             = "debian-cloud/debian-9"
      auto_delete       = true
      boot              = true
      # backup the disk every day
      resource_policies = ["${google_compute_resource_policy.daily_backup.id}"]
    }
  }

  network_interface {
    network = "default"
  }

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.name}"
    propagate_at_launch = true
  }

  labels = {
    environment = "dev"
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "${var.service_account}"
    scopes = ["cloud-platform"]
  }

  // metadata {
  //   # ssh-keys = "${var.ssh_keys}"
  //   ssh-keys = "matt.crook11@gmail.com:${file("~/.ssh/id_rsa.pub")}"
  // }

  metadata_startup_script = "${data.template_file.startup_script.rendered}"
}


resource "google_compute_forwarding_rule" "compute_forwarding_rule" {
  name       = "${var.name}-forwarding-rule"
  target     = "${google_compute_target_pool.compute_target_pool.self_link}"
  port_range = "8080"
  ip_address = "${google_compute_address.compute_address.address}"
}


resource "google_compute_target_pool" "compute_target_pool" {
  name          = "${var.name}-target-pool"
  health_checks = ["${google_compute_http_health_check.compute_health_check.name}"]
}

# Manages a VM instance template resource within GCE. To use "google_compute_autoscaler" use this to launch a cluster of VM's instead of creating a single VM.
# Equivalent to launch configuration resource in aws.
# Takes care of launching a cluster of instances, monitoring health, replacing failed instances, and ajusting size of cluster in response to load.
resource "google_compute_instance_group_manager" "instance_group_manager" {
  name               = "${var.name}-example-group-manager"
  description        = "This template is used to create instance group instances"
  instance_template  = "${google_compute_instance_template.instance_template.self_link}"
  target_pools       = ["${google_compute_target_pool.compute_target_pool.self_link}"]
  base_instance_name = "${var.name}"

  auto_healing_policies {
    health_check      = "${google_compute_health_check.autohealing.id}"
    initial_delay_sec = 300
  }
}

# Represents an Autoscaler resource.
# Autoscalers allow you to automatically scale virtual machine instances in managed instance groups
# according to an autoscaling policy that you define.
# Equivalent to asg (auto scaling group) resource in aws.
# Using this to create/manage a cluster of VM's instead of creating a single instance.
resource "google_compute_autoscaler" "autoscaling_group" {
  name   = "${var.name}-autoscaler"
  zone   = "${var.zone}"
  target = "${google_compute_instance_group_manager.instance_group_manager.id}"

  autoscaling_policy {
    max_replicas    = "${var.max_replicas}"
    min_replicas    = "${var.min_replicas}"
    cooldown_period = 60

    cpu_utilization {
      target = 0.5
    }
  }
}

resource "google_compute_backend_service" "backend" {
  name        = "${var.name}-backend-service"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10
  enable_cdn  = false

  backend {
    group = "${google_compute_instance_group_manager.instance_group_manager.instance_group}"
  }

  health_checks = ["${google_compute_http_health_check.compute_health_check.self_link}"]
}


resource "google_compute_http_health_check" "compute_health_check" {
  name                 = "${var.name}-health-check"
  request_path         = "/"
  check_interval_sec   = 30
  timeout_sec          = 3
  healthy_threshold    = 2
  unhealthy_threshold  = 2
  port                 = "${var.server_port}"
}


resource "google_compute_firewall" "instance" {
  name    = "${var.name}-firewall-instance"
  network = "default"

  source_ranges = "${locals.all_ips}"

  allow {
    protocol = "${locals.tcp_protocol}"
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
    port         = "8080"
  }
}

resource "google_compute_resource_policy" "daily_backup" {
  name   = "${var.compute_resource_policy_name}"
  region = "${var.region}"
  snapshot_schedule_policy {
    schedule {
      daily_schedule {
        days_in_cycle = 1
        start_time    = "04:00"
      }
    }
  }
}
