variable "sts_name" {
  type = string
}

variable "sts_name_postfix" {
  type    = string
  default = "lotus-0"
}

variable "namespace" {
  type = string
}

variable "git_repo" {
  type = string
}

variable "git_author" {
  type    = string
  default = "Protofire Bot"
}

variable "git_email" {
  type    = string
  default = "openworklabbot@gmail.com"
}

variable "schedule" {
  type    = string
  default = "0 0 * * *"
}

variable "blocks_to_export" {
  type    = number
  default = 900
}
