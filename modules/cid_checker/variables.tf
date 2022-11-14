
variable "get_global_configuration" {}

variable "bucket_name" {
  description = "Name of S3 bucket."
  type        = string
}

variable "get_sa_namespace" {
  description = "Variables for kubernetes service account."
  type        = string
}
