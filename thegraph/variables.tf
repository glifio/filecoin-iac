variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "aws_profile" {
  type    = string
  default = "filecoin"
}

variable "resource_prefix" {
  type    = string
  default = "apn1-production-thegraph"
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

variable "rds_engine" {
  type    = string
  default = "postgres"
}

variable "rds_engine_version" {
  type    = string
  default = "16.4"
}

variable "rds_instance_class" {
  type    = string
  default = "db.m5.large"
}

variable "rds_allocated_storage" {
  type    = number
  default = 50
}

variable "kubernetes_cluster_name" {
  type    = string
  default = "filecoin-mainnet-apn1-glif-eks"
}

variable "kubernetes_namespace" {
  type    = string
  default = "thegraph-prod"
}

variable "ingress_class" {
  type    = string
  default = "kong-external-lb"
}

variable "elb_name_tag" {
  type    = string
  default = "filecoin-mainnet-apn1-glif-kong-external"
}

variable "domain_zone" {
  type = string
  default = "node.glif.io"
}
