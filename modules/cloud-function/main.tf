resource "google_service_account" "fn_service_act" {
  account_id   = var.function_name
  description  = "Used by '${var.function_name}'"
  display_name = var.function_name
  project      = var.project_id
}

data "archive_file" "zip" {
  type        = "zip"
  source_dir  = var.source_dir
  output_path = "/tmp/${var.function_name}.zip"
  excludes    = ["README.md", "*.sh"]
}

resource "google_project_iam_binding" "functions-service-account" {
  project = var.project_id
  role    = "roles/cloudfunctions.admin"

  members = [
    "serviceAccount:${google_service_account.fn_service_act.email}"
  ]
}

resource "google_storage_bucket_object" "function-zip" {
  bucket = var.source_bucket
  name   = "${var.function_name}/${data.archive_file.zip.output_md5}.zip"
  source = data.archive_file.zip.output_path
}

resource "google_cloudfunctions2_function" "function-from-yaml" {
  name           = var.function_name
  description    = var.function_description
  project        = var.project_id
  location       = var.project_region

  build_config {
    runtime     = "go122"
    entry_point = var.entry_point

    source {
      storage_source {
        bucket = google_storage_bucket_object.function-zip.bucket
        object = google_storage_bucket_object.function-zip.name
      }
    }
  }

  service_config {
    min_instance_count    = 0
    max_instance_count    = 1
    available_memory      = "256Mi"
    timeout_seconds       = 60
    service_account_email = google_service_account.fn_service_act.email
    environment_variables = var.runtime_vars
  }
}

