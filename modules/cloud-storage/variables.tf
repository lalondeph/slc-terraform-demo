variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud project where the resources will be created."
}

variable "project_region" {
  type        = string
  default     = "northamerica-northeast1"
  description = "The region where the Google Cloud resources (buckets, etc.) will be created."
}

variable "bucket_name" {
  type        = string
  description = "The name of the Google Cloud Storage bucket to be created."
}

variable "lifecycle_rules" {
  type        = string
  description = "Lifecycle rules for the bucket. Example format: 'delete_30d' (deletes objects older than 30 days)."
}

variable "iam_members" {
  type = list(object({
    role   = string
    member = string
  }))
  default     = []
  description = "A list of IAM roles and members to be assigned to the bucket."
}

variable "bucket_objects" {
  type        = list(string)
  default     = []
  description = "A list of objects (e.g., folders or files) to be created in the bucket."
}
  