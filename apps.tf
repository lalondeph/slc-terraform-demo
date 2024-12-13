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

resource "google_project_iam_member" "members-from-yaml" {
  for_each = local.apps.members
  project  = var.google_project_id
  role     = each.value.role
  member   = each.value.member
}

module "cloud-storage-from-yaml" {
  source   = "./modules/cloud-storage"
  for_each = local.apps.buckets

  project_id            = var.google_project_id
  project_region        = var.project_region
  bucket_name           = each.key
  lifecycle_rules       = each.value.lifecycle_rule
  iam_members           = each.value.iam_members
  bucket_objects        = each.value.bucket_objects
}