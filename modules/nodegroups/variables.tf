variable "get_global_configuration" {}
variable "get_eks_nodegroups_global_configuration" {}
variable "get_instance_type" {
  type    = string
}
variable "is_spot_instance" {
  type    = bool
  default = false
}

variable "get_nodegroup_name" {
  type    = string
  default = null
}

variable "assign_to_space00_07_nodes" {
  type    = bool
  default = false
}

variable "public_key" {
  type    = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHMC7lI58Is6qjyARyNAJw9jm/LWcmjXsIZL5t2urMcl common alexey_kulik"
}

variable "get_desired_size" {
  type    = number
  default = 2
}

variable "get_max_size" {
  type    = number
  default = 3
}

variable "get_min_size" {
  type    = number
  default = 1
}

variable "availability_zone_postfix" {
  type    = string
  default = "a"
}

variable "ami_type" {
  type    = string
  default = "AL2_x86_64"
}

variable "user_data_script" {
  type    = string
  default = "nvme.sh"
}

variable "use_existing_ebs" {
  type        = bool
  default     = false
  description = "If true, EBS volumes matching ebs_tenant will be attached on launch"
}

variable "ebs_tenant" {
  type        = string
  default     = null
  description = "Tenant tag value to search EBS volumes by"
}

variable "namespace_secret" {}

variable "exist_secret" {
  default = null
}

variable "create_new_secret" {
  type = bool
  default = false
}

# -------------------- kong variables------------------- #

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


