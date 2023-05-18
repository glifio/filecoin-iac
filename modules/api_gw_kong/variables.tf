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
  type    = bool
  default = false
}

variable "mirror_to" {
  default = []
}

variable "certificate_issuer" {
  type        = string
  default     = ""
  description = "If provided, use certificate issuer for ssl"
}

variable "affix_ingress_class" {
  type        = bool
  default     = true
  description = "If true, ingress class name is kong-name-lb"
}

variable "affix_upstream_service" {
  type        = bool
  default     = false
  description = "If true, add -lotus at the end of upstream service name"
}
