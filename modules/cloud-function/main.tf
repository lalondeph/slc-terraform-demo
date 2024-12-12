data "archive_file" "zip" {
  type        = "zip"
  source_dir  = var.source_dir
  excludes    = ["curl", "cmd", "README.md", "start.sh"]
  output_path = "/tmp/${var.function_name}.zip"
}

resource "google_service_account" "fn_service_act" {
  account_id   = var.function_name
  description  = "Used by '${var.function_name}'"
  display_name = var.function_name
  project      = var.project_id
}

