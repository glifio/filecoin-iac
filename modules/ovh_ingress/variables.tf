variable "name" {
  type        = string
  description = "Ingress name"
}

variable "http_host" {
  type        = string
  description = "HTTP host to match"
}

variable "http_path" {
  type        = string
  default     = "/(.*)"
  description = "HTTP path to match"
}

variable "http_path_type" {
  type        = string
  default     = "Exact"
  description = "HTTP path comparison type"
}

variable "service_name" {
  type        = string
  description = "Backend service name"
}

variable "service_port" {
  type        = number
  description = "Backend service port"
}

variable "namespace" {
  type        = string
  default     = "network"
  description = "Namespace to create the ingress in"
}

variable "incress_class" {
  type        = string
  default     = "default"
  description = "Ingress class name"
}

variable "enable_path_transformer" {
  type        = bool
  default     = true
  description = "If true, transform path as specified in replace_path_rule"
}

variable "replace_path_rule" {
  type        = string
  default     = "/$(uri_captures[1])"
  description = "Regular expression to transform the path"
}

variable "enable_access_control" {
  type        = bool
  default     = false
  description = "Enable Authorization header add/replace"
}

variable "access_control_public" {
  type        = bool
  default     = false
  description = "If true, add/replace Authorization header with a valid JWT token. Otherwise, with the invalid one."
}

variable "access_control_replace" {
  type        = bool
  default     = false
  description = "If true, replace Authorization header on top of adding it if it's not present."
}

variable "secret_name" {
  type        = string
  default     = null
  description = "Secret name to get authorization token from"
}

variable "enable_cors" {
  type        = bool
  default     = true
  description = "If true, enable CORS policy"
}

variable "enable_return_json" {
  type        = bool
  default     = true
  description = "If true, add Content-Type: application/json header to response"
}

variable "auth_token_attribute" {
  type        = string
  default     = "jwt_token_kong_rw"
  description = "Attribute of secret to exteact auth token from"
}

variable "enable_limit_reqs_wo_header" {
  type        = bool
  default     = false
  description = "Enable rate-limiting for requests without Authorization header"
}

variable "enable_ext_token_auth" {
  type        = bool
  default     = false
  description = "Enable external token authorization for requests with Authorization header"
}

variable "ext_token_auth_url" {
  type        = string
  default     = "http://glif-auth-app-svc.default:3000/api/auth"
  description = "URL of the external Auth service that Kong will send request data to"
}

variable "enable_redirect" {
  type = bool
  default = false
  description = "Redirect requests to the specified URL"
}

variable "redirect_location" {
  type = string
  default = "https://api.node.glif.io"
  description = "Location to redirect incoming requests to"
}
