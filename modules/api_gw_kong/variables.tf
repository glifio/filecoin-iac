variable "stage_name" {
  type = string
  description = "If provided, use for the naming ingress."
}

variable "domain_name" {
  type = string
  description = "List of s3 buckets names."
}

variable "ingress_class" {
  type = string
  description = "Ingress class name."
}

variable "global_config" {}

variable "namespace" {
  type = string
}

variable "upstream_service" {
  type = string
  description = "Backend service name."
}

variable "upstream_port" {
  type    = number
  default = 2346
  description = "Backend service port."
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
  description = "If provided, use the certificate issuer for SSL"
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
