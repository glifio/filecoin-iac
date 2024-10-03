variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "aws_profile" {
  type    = string
  default = "filecoin"
}

variable "common_tags" {
  type = map(string)
  default = {
    Project         = "Filecoin"
    Environment     = "mainnet"
    Sub_environment = "glif"
    ProvisionedWith = "Terraform"
  }
}

variable "kubernetes_namespace" {
  type    = string
  default = "proteus-shield"
}
