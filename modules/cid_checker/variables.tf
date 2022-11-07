
variable "bucket_name" {
  description = "Name of S3 bucket."
  type = string
}

variable "force_destroy" {
  description = "If `true`, will destroy S3 bucket. Defaults to `false`."
  type = bool
  default = false
}

variable "tags" {
  description = "Map of general common tags."
  type = map(any)
  default = {}
}

variable "oidc" {
  description = "OpenID Connect endpoint URLs for cluster."
  type = string
}

variable "name_prefix" {
  type = string
}

variable "kubernetes_service_account" {
  description = "Variables for kubernetes service account"
  type = object({
    namespace   = string
  })
    default = {
      namespace        = "default"
    }
  }

