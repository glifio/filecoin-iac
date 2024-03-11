variable "stage_name" {
  type        = string
  description = "If provided, use for the naming ingress."
}

variable "domain_name" {
  type        = string
  description = "List of s3 buckets names."
}

variable "ingress_class" {
  type        = string
  description = "Ingress class name."
}

variable "global_config" {}

variable "namespace" {
  type        = string
  description = "The Kubernetes namespace to deploy the ingresses in"
}

variable "upstream_service" {
  type        = string
  description = "Backend service name."
}

variable "upstream_port" {
  type        = number
  default     = 2346
  description = "Backend service port."
}

variable "override_rpc_v0_service" {
  type        = string
  default     = null
  description = "Override the upstream service for the /rpc/v0 path"
}

variable "override_rpc_v0_port" {
  type        = number
  default     = null
  description = "Override the upstream port for the /rpc/v0 path"
}

variable "override_rpc_v1_service" {
  type        = string
  default     = null
  description = "Override the upstream service for the /rpc/v1 path"
}

variable "override_rpc_v1_port" {
  type        = number
  default     = null
  description = "Override the upstream port for the /rpc/v1 path"
}

variable "override_daemon_service" {
  type        = string
  default     = null
  description = "Override the upstream service for the ingresses that lead to daemon"
}

variable "override_daemon_port" {
  type        = number
  default     = 1234
  description = "Override the upstream port for the ingresses that lead to daemon"
}

variable "enable_mirroring" {
  type        = bool
  default     = false
  description = "If true, mirror incoming requests to endpoints specified in mirror_to"
}

variable "mirror_to" {
  default     = []
  description = "An array of endpoints to mirror incoming requests to"
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

variable "preserve_host" {
  type = bool
  default = true
}

variable "enable_limit_reqs_wo_header" {
  type = bool
  default = false
  description = "If enabled, requests without Authorization header will be rate-limited."
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
