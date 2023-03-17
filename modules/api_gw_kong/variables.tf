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
  type    = number
  default = 2346
}

variable "override_rpc_v0_service" {
  type    = string
  default = null
}

variable "override_rpc_v0_port" {
  type    = number
  default = null
}

variable "override_rpc_v1_service" {
  type    = string
  default = null
}

variable "override_rpc_v1_port" {
  type    = number
  default = null
}

variable "override_daemon_service" {
  type    = string
  default = null
}

variable "override_daemon_port" {
  type    = number
  default = 1234
}

variable "enable_mirroring" {
  type = bool
  default = false
}

variable "mirror_to" {
  default = []
}