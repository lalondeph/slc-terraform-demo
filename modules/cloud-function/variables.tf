variable "project_id" {}
variable "project_region" { default = "northamerica-northeast1" }
variable "function_name" {}
variable "function_description" {}
variable "source_dir" {}
variable "entry_point" {}
variable "source_bucket" {}
variable "runtime_vars" { type = map(string) }