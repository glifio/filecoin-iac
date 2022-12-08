variable "git_repository_name" {}
variable "get_global_configuration" {}

variable "is_build_only" {
  type    = bool
  default = false
}

variable "terraform_policy" {
  default = false
}

variable "build_timeout" {
  default = 40
}

variable "concurrent_build_limit_default" {
  default = 10
}


variable "concurrent_build_limit" {
  default = 1
}

variable "is_build_concurrent" {
  type    = bool
  default = true
}

variable "environment_compute_type" {
  default = "BUILD_GENERAL1_SMALL"
}

variable "codebuild_image" {
  default = "aws/codebuild/amazonlinux2-aarch64-standard:2.0"
}

variable "notifications_enabled" {
  description = "Enable codebuild notifications via SNS"
  default     = true
}

variable "badge_enabled" {
  default = true
}

variable "privileged_mode" {
  type    = bool
  default = false
}

variable "specific_branch" {
  type    = string
  default = null
}

variable "specific_envs" {
  type    = map
  default = {}
}
