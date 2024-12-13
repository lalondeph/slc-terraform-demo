# Create the Google Cloud Storage bucket with the specified name and lifecycle rules.
resource "google_storage_bucket" "bucket" {
  name     = var.bucket_name
  location = var.project_region

  lifecycle_rule {
    condition {
      age = tonumber(regex("delete_(\\d+)d", var.lifecycle_rules)[0])
    }
    action {
      type = "Delete"
    }
  }
}

# Assign IAM roles to the bucket for the specified members.
resource "google_storage_bucket_iam_member" "bucket-members" {
  for_each = { for member in var.iam_members : member.member => member }

  bucket = google_storage_bucket.bucket.name
  role   = each.value.role
  member = each.value.member
}

# Upload or create objects (files or folders) in the bucket.
resource "google_storage_bucket_object" "objects" {
  for_each = toset(var.bucket_objects)

  name    = "${each.value}/"
  bucket  = google_storage_bucket.bucket.name
  content = "these file are imaginary"
}
