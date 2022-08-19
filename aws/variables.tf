variable "profile" {
  type = map(string)
  default = {
    "filecoin-glif-mainnet-apn1" = "filecoin"
    "filecoin-glif-dev-apn1"     = "filecoin"
    "default"                    = "_dont_use_default_namespace"
  }
}

variable "region" {
  type    = string
  default = "us-east-2"
}

variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "cidr_block" {
  default = "192.168.0.0/16"
}

variable "sub_environment" {
  type = string
}

variable "azs_count" {
  type    = number
  default = 3
}

variable "eks_cluster_version" {
  type    = string
  default = "1.23"
}

variable "route53_domain" {
  type = string
}

variable "git_configuration" {}
variable "branch" {
  type = string
}
