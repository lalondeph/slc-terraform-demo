variable "project_id" {
  description = "The ID of the Google Cloud project where the resources will be created."
  type        = string
}

variable "project_region" {
  description = "The region where the Google Cloud resources (buckets, etc.) will be created."
  type        = string
  default     = "northamerica-northeast1"
}

variable "bucket_name" {
  description = "The name of the Google Cloud Storage bucket to be created."
  type        = string
}

variable "lifecycle_rules" {
  description = "Lifecycle rules for the bucket. Example format: 'delete_30d' (deletes objects older than 30 days)."
  type        = string
}

variable "iam_members" {
  description = "A map of IAM roles and members to be assigned to the bucket, keyed by a unique identifier."
  type = list(object({
    role   = string
    member = string
  }))
  default = {}
}

variable "bucket_objects" {
  description = "A list of objects (e.g., folders or files) to be created in the bucket."
  type        = list(string)
  default     = []
}
  