variable "stage_name" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "ingress_class" {
  type = string
}

variable "global_config" {}

variable "namespace" {
  type = string
}

variable "upstream_service" {
  type = string
}

variable "upstream_port" {
  type = number
  default = 2346
}
