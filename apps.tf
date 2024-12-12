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