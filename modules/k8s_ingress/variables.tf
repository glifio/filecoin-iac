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
  default = true
}

variable "type_lb_scheme" {
  type = string
}

variable "as_is_ingress_backend_service_name" {
  type        = bool
  description = "If the parameter is true, then '-service' string will be added in the end of the line. The logic is useful when we deploy an app"
  default     = false
}

variable "get_ingress_pathType" {
  type    = string
  default = "Exact"
}

variable "enable_whitelist_ip" {
  type    = bool
  default = false
}

variable "is_kong_auth_header_block_public_access" {
  type    = bool
  default = true
}

variable "get_whitelist_ips" {
  default = [
    "212.58.119.174",
    "91.149.128.236",
    "216.144.250.150",
    "69.162.124.224/28",
    "63.143.42.240/28",
    "216.245.221.80/28",
    "46.137.190.132",
    "122.248.234.23",
    "188.226.183.141",
    "178.62.52.237",
    "54.79.28.129",
    "54.94.142.218",
    "104.131.107.63",
    "54.67.10.127",
    "54.64.67.106",
    "159.203.30.41",
    "46.101.250.135",
    "18.221.56.27",
    "52.60.129.180",
    "159.89.8.111",
    "146.185.143.14",
    "139.59.173.249",
    "165.227.83.148",
    "128.199.195.156",
    "138.197.150.151",
    "34.233.66.117"
  ]
}

variable "return_json" {
  type    = bool
  default = false
}


var