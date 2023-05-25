variable "get_global_configuration" {}
variable "get_eks_nodegroups_global_configuration" {}
variable "get_instance_type" {
  type = string
}
variable "is_spot_instance" {
  type    = bool
  default = false
}

variable "get_nodegroup_name" {
  type    = string
  default = null
}

variable "assign_to_archive_node" {
  type    = bool
  default = false
}

variable "public_key" {
  type    = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHMC7lI58Is6qjyARyNAJw9jm/LWcmjXsIZL5t2urMcl common alexey_kulik"
}

variable "get_desired_size" {
  type    = number
  default = 1
}

variable "get_max_size" {
  type    = number
  default = 2
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

variable "get_namespace" {}

variable "exist_secret" {
  default = null
}

variable "create_new_secret" {
  type    = bool
  default = false
}


variable "type_lb_scheme" {
  type    = string
  default = null
}

variable "false_auth" {
  type    = bool
  default = false
}

#variable "get_whitelist_ips" {
#  default = [
#    "212.58.119.174",
#    "91.149.128.236",
#    "216.144.250.150",
#    "69.162.124.224/28",
#    "63.143.42.240/28",
#    "216.245.221.80/28",
#    "46.137.190.132",
#    "122.248.234.23",
#    "188.226.183.141",
#    "178.62.52.237",
#    "54.79.28.129",
#    "54.94.142.218",
#    "104.131.107.63",
#    "54.67.10.127",
#    "54.64.67.106",
#    "159.203.30.41",
#    "46.101.250.135",
#    "18.221.56.27",
#    "52.60.129.180",
#    "159.89.8.111",
#    "146.185.143.14",
#    "139.59.173.249",
#    "165.227.83.148",
#    "128.199.195.156",
#    "138.197.150.151",
#    "34.233.66.117"
#  ]
#}



## Variables for kong ##


variable "http_host" {
  type        = string
  description = "HTTP host to match"
  default     = null
}

variable "http_path" {
  type        = string
  description = "HTTP path to match"
  default     = null
}

variable "http_path_type" {
  type        = string
  default     = "Exact"
  description = "HTTP path comparison type"
}


variable "service_port" {
  type        = number
  description = "Backend service port"
  default     = null
}


variable "enable_path_transformer" {
  type        = bool
  default     = true
  description = "If true, transform path as specified in replace_path_rule"
}

variable "enable_switch_transformer" {
  type        = bool
  default     = false
  description = "If true, switch the path as specified in any switch_path"
}

variable "replace_path_rule" {
  type        = string
  default     = "/$(uri_captures[1])"
  description = "Regular expression to transform the path"
}

variable "enable_public_access" {
  type        = bool
  default     = false
  description = "If true, add Authorization header"
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

variable "create_secret" {
  type    = bool
  default = true
}

variable "create_ingress_kong" {
  type    = bool
  default = true
}

variable "create_ingress_kong_ipfs" {
  type    = bool
  default = true
}

variable "service_port_ipfs" {
  type    = string
  default = null
}

variable "http_path_ipfs" {
  type        = string
  description = "HTTP path to match"
  default     = null
}

variable "prevent_destroy" {
  type = bool
  default = true
}


##check for new vars secret ##

#variable "generator_config" {
#  type        = map(any)
#  description = "Configuration for the prefix generator"
#}

variable "name" {
  type        = string
  description = "Secret name"
  default = ""
}

variable "create_k8s_secret" {
  type        = bool
  default     = true
  description = "Create secret in Kubernetes"
}

variable "create_aws_secret" {
  type        = bool
  default     = true
  description = "Create secret in AWS"
}

variable "k8s_secret_postfix" {
  type        = string
  default     = "-lotus-secret"
  description = "Postfix of the Kubernetes secret"
}

variable "from_secret" {
  type        = string
  default     = ""
  description = "Secret to copy secret_string from"
}
