data "template_file" "startup_script" {
  template = "${file("${path.module}/startup-script.sh")}"

  vars {
    public_ip       = "${google_compute_address.example.address}"
    instance_group  = "${google_compute_instance_group_manager.instance_group_manager.instance_group}"
    status          = "${google_compute_instance_group_manager.instance_group_manager.status}"
  }
}
