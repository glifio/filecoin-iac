variable "get_global_configuration" {}

variable "get_ingress_http_path" {
  type = string
}

variable "get_ingress_backend_service_name" {
  type = string
}

variable "get_ingress_backend_service_port" {
  type = number
}

variable "get_rule_host" {
  type = string
}

variable "get_ingress_namespace" {
  type = string
}

variable "get_jwt_header_wr_token_name" {
  type    = string
  default = "jwt_token_kong_rw"
}

variable "kong_plugin_replace_url" {
  type    = string
  default = "/$(uri_captures[1])"
}

variable "is_kong_auth_header_enabled" {
  type    = bool
  default = true
}

variable "is_kong_transformer_header_enabled" {
  type    = bool
  default = true
}

variable "is_kong_cors_enabled" {
  type    = bool
  default = false
}

variable "type_lb_scheme" {
  type = string
}

variable "as_is_ingress_backend_service_name" {
  type        = bool
  description = "It the pararmeter true, then -service will be added in the end of the service. The logic is useful when we deploy app"
  default     = false
}

variable "get_ingress_pathType" {
  type = string
  default = "Exact"
}
