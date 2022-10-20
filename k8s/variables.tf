variable "profile" {
  type = map(string)
  default = {
    "filecoin-dev-apn1-glif-eks"     = "filecoin"
    "filecoin-mainnet-apn1-glif-eks" = "filecoin"
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

variable "sub_environment" {
  type = string
}

variable "lb_controller_name" {
  type    = string
  default = "aws-load-balancer-controller"
}

variable "ebs_controller_name" {
  type    = string
  default = "aws-ebs-csi-driver"
}

variable "route53_domain" {
  #  type = string
}

variable "http_endpoint_uri" {
  type = string
}

variable "whitelist_ips" {}

