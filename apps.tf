locals {
  is_prod = var.google_project_id != "free-sandbox-444203"
  apps    = local.is_prod ? yamldecode(file("${path.root}/apps/prod.yaml")) : yamldecode(file("${path.root}/apps/pilot.yaml"))
}

data "google_project" "project" {}

resource "google_project_service" "cloudresourcemanager" {
  project            = var.google_project_id
  service            = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = false #
}

resource "google_storage_bucket" "cloud-fn-source" {
  name                        = "cloud-fn-source"
  project                     = var.google_project_id
  location                    = var.project_region
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
}

resource "google_project_iam_member" "members-from-yaml" {
  for_each = local.apps.members
  project  = var.google_project_id
  role     = each.value.role
  member   = each.value.member
}

resource "google_cloud_run_v2_function" "fn-from-yaml" {
  source   = "./modules/cloud-function"
  for_each = local.apps.functions

  project_id           = var.google_project_id
  function_name        = each.name
  function_description = each.description
  source_dir           = "${path.root}/golang/cloud-function"
  entry_point          = each.entry_point
  source_bucket        = google_storage_bucket.cloud-fn-source.name
  runtime_vars         = each.runtime_vars
}