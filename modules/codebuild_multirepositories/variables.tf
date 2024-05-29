variable "git_repository_name" {}
variable "get_global_configuration" {}

variable "create_build_webhook" {
  type    = bool
  default = true
}

variable "create_deploy_webhook" {
  type    = bool
  default = true
}

variable "is_build_only" {
  type    = bool
  default = false
}

variable "repo_docker_branch" {
  type    = string
  default = "master"
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

variable "github_cd_token_secret" {
  type    = string
  default = "github_cd_token_secret"
}

variable "webhook_custom_type" {
  type    = bool
  default = false
}

variable "get_webhook_custom_type" {
  type    = string
  default = null
}

variable "buildspec_logic" {
  type    = string
  default = null
}

variable "environment_type" {
  type    = string
  default = "ARM_CONTAINER"
}

variable "project_name" {
  type = string
}