resource "google_spanner_instance" "spanner" {
    project      = "${var.project}"
    config       = "${var.regional_config}"
    display_name = "${var.gsi_display_name}"
    num_nodes    = "${var.spanner_num_nodes}"

    # Set for testing purposes - Deletes all backups
    force_destroy = true

    labels = {
        "env" = "dev"
    }
}
