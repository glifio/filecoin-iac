variable "generator_inputs" {
  type        = map(string)
  description = "Input parameters for generator module"
}

variable "github_org" {
  type        = string
  default     = "protofire"
  description = "GitHub Organization source repository is located in"
}

variable "github_repo" {
  type        = string
  default     = "cid-checker"
  description = "GitHub source repository"
}

variable "github_branch" {
  type        = string
  default     = "main"
  description = "GitHub source repository branch"
}

variable "project_name" {
  type        = string
  description = "CodeBuild project name"
}

variable "project_description" {
  type        = string
  default     = ""
  description = "Description of the CodeBuild project"
}

variable "build_timeout" {
  type        = number
  default     = 40
  description = "Number of minutes after which build fails"
}

variable "concurrent_build_limit" {
  type        = number
  default     = 1
  description = "Number of concurrent builds"
}

variable "badge_enabled" {
  type        = bool
  default     = true
  description = "Enable build badge"
}

variable "env_compute_type" {
  type        = string
  default     = "BUILD_GENERAL1_SMALL"
  description = "Environment compute type"
}

variable "env_image" {
  type        = string
  default     = "aws/codebuild/standard:6.0"
  description = "CodeBuild image"
}

variable "env_type" {
  type        = string
  default     = "LINUX_CONTAINER"
  description = "Environment type"
}

variable "env_privileged_mode" {
  type        = bool
  default     = false
  description = "Run CodeBuild in the privileged mode"
}

variable "environment_variables" {
  type        = map(string)
  default     = {}
  description = "Environment variables to pass to CodeBuild"
}

variable "buildspec" {
  type        = string
  default     = "buildspec.yaml"
  description = "Buildspec file name or the entire specification"
}

variable "s3_bucket" {
  type = string
  default = "glif-ipc"
  description = "S3 bucket to store CodeBuild artifacts in"
}

variable "artifact_name" {
  type = string
  default = "ipc-cli.linux-amd64"
  description = "CodeBuild artifact name"
}
