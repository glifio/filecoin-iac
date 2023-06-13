variable "project" {
  type        = string
  default     = "filecoin"
  description = "Project name (used for tagging)"
}

variable "environment" {
  type        = string
  default     = "production"
  description = "Environment name (used for tagging)"
}

variable "region" {
  type        = string
  default     = "ap-northeast-1"
  description = "AWS region"
}

variable "sub_environment" {
  type        = string
  default     = "glif"
  description = "Subenvironment name (used for tagging)"
}

variable "profile" {
  type        = string
  default     = "filecoin"
  description = "AWS credentials profile name"
}
