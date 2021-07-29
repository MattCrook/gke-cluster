provider "google" {
    # To login run: gcloud beta auth application-default login
    project     = var.project_id
    region      = var.region
    zone        = var.zone
}

terraform {
    backend "gcs" {
        bucket      = "core-tf-state"
        prefix      = "global/terraform.tfstate"
        # credentials = "./credentials.json"
    }
}

# GCS bucket to store logging, as referenced in the state bucket.
resource "google_storage_bucket" "logging_bucket" {
    count = var.enable_logging ? 1 : 0

    name          = "tf-gcs-logging-bucket"
    location      = "US"
    storage_class = "${var.storage_class}"
    project       = "${var.project_id}"
    # This is only here so we can destroy the bucket as part of automated tests. You should not copy this for production usage.
    force_destroy = true

    versioning {
        enabled = "${var.versioning}"
    }

    labels {
        env = "stage"
        bucket = "logging"
    }

    lifecycle_rules = [{
        action = {
        type = "Delete"
        }
        condition = {
        age        = 365
        with_state = "ANY"
        }
    }]

    iam_members = [{
        role   = "roles/storage.objectViewer"
        member = "user:matt.crook11@gmail.com"
    }]
}

# Our gcs bucket to store the state. Will use "gcs" as backend which is this bucket.
# Google Cloud Platform like most of the remote backends natively supports locking. AWS doesn't support locking natively via S3 but it does via DynamoDB.
resource "google_storage_bucket" "tf_state" {
    name          = "${var.db_remote_state_bucket}"
    location      = "US"
    storage_class = "${var.storage_class}"
    project       = "${var.project_id}"
    # This is only here so we can destroy the bucket as part of automated tests. You should not copy this for production usage.
    force_destroy = true

    versioning {
        enabled = "${var.versioning}"
    }

    labels {
        env = "stage"
        bucket = "state"
    }

    dynamic "logging" {
        for_each = var.log_bucket == null ? [] : [var.log_bucket]
        content {
        log_bucket        = "${google_storage_bucket.logging_bucket}"
        log_object_prefix = "${google_storage_bucket.logging_bucket.name}"
        }
    }

    lifecycle_rules = [{
        action = {
        type = "Delete"
        }
        condition = {
        age        = 365
        with_state = "ANY"
        }
    }]

    iam_members = [{
        role   = "roles/storage.objectViewer"
        member = "user:matt.crook11@gmail.com"
    }]
}

resource "google_storage_bucket_iam_member" "members" {
    for_each = {
        for m in var.iam_members : "${m.role} ${m.member} => m
    }

    bucket = "${google_storage_bucket.bucket.name}"
    role   = "${each.value.role}"
    member = "${each.value.member}"
}

resource "google_storage_bucket_acl" "tf-bucket-acl" {
    depends_on = ["google_storage_bucket.tf_state"]
    bucket = "${google_storage_bucket.tf_state.name}"
    role_entity = ["${var.acl}"]
}

resource "google_storage_bucket_acl" "logging-bucket-acl" {
    count = var.enable_logging ? 1 : 0

    depends_on = ["google_storage_bucket.logging_bucket"]
    bucket = "${google_storage_bucket.logging_bucket.name}"
    role_entity = ["${var.acl}"]
}

resource "google_storage_default_object_acl" "default-acl" {
    bucket = "${var.bucket_name}"
    role_entity = ["${var.acl}"]
}

resource "google_storage_object_acl" "object-acl" {
    bucket = "${var.bucket_name}"
    object = "${var.object_name}"
    role_entity = ["${var.acl}"]
}

# Bucket Content
resource "google_storage_bucket_object" "object" {
  name   = "${var.filename}"
  content = "${var.content}"
  bucket = "${var.bucket_name}"
  content_type = "${var.content_type}"
}
