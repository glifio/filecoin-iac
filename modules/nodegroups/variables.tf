variable "get_global_configuration" {
  description = "Set of inputs used by module generator for the naming."
}
variable "get_eks_nodegroups_global_configuration" {
  description = "Set of basic inputs  to EKS cluster and networking settings."
}
variable "get_instance_type" {
  type = string
  description = "List of instance types associated with the EKS Node Group. Defaults to on-demand [`r6gd.4xlarge`], to spot [`m5d.8xlarge,r5ad.8xlarge`]"
}

variable "is_spot_instance" {
  type    = bool
  default = false
  description = "If value `TRUE` run the launch template for spot."
}

variable "get_nodegroup_name" {
  type    = string
  default = null
  description = "Name of the nodegroup."
}

variable "assign_to_archive_node" {
  type    = bool
  default = false
  description = "If value `TRUE` assign archive pods only on archival nodes."
}

variable "public_key" {
  type    = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHMC7lI58Is6qjyARyNAJw9jm/LWcmjXsIZL5t2urMcl common alexey_kulik"
  description = "SSH key that provides access for remote communication with the instances."
}

variable "get_desired_size" {
  type    = number
  default = 1
  description = "Desired number of instances in the scaling group."
}

variable "get_max_size" {
  type    = number
  default = 2
  description = "Maximum number of instances in the scaling group."
}

variable "get_min_size" {
  type    = number
  default = 1
  description = "Minimum number of instances in the scaling group."
}

variable "availability_zone_postfix" {
  type    = string
  default = "a"
  description = "Availability zone to deploy the nodegroup to."
}

variable "ami_type" {
  type    = string
  default = "AL2_x86_64"
  description = "For on-demand instances used the AWS Graviton2 made Arm-based use the type AMI `AL2_ARM_64`. For spot instances used default value."
}

variable "user_data_script" {
  type    = string
  default = "nvme.sh"
  description = "Runs the scripts for creates a RAID on the volumes."
}

variable "use_existing_ebs" {
  type        = bool
  default     = false
  description = "If true, EBS volumes matching ebs_tenant will be attached on launch."
}

variable "ebs_tenant" {
  type        = string
  default     = null
  description = "Tenant tag value to search EBS volumes by."
}

variable "get_namespace" {
  description = "Kubernetes namespace."
}


variable "type_lb_scheme" {
  type    = string
  default = "external"
  description = "If external, ingress has to go on external LB."
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


## Variables for kong ##


variable "http_host" {
  type        = string
  description = "HTTP host to match."
  default     = null
}

variable "http_path" {
  type        = string
  description = "HTTP path to match."
  default     = null
}

variable "http_path_type" {
  type        = string
  default     = "Exact"
  description = "HTTP path comparison type."
}


variable "service_port" {
  type        = number
  description = "Backend service port."
  default     = null
}


variable "enable_path_transformer" {
  type        = bool
  default     = true
  description = "If true, transform path as specified in replace_path_rule."
}

variable "enable_switch_transformer" {
  type        = bool
  default     = false
  description = "If true, switch the path as specified in any switch_path."
}

variable "replace_path_rule" {
  type        = string
  default     = "/$(uri_captures[1])"
  description = "Regular expression to transform the path."
}

variable "enable_public_access" {
  type        = bool
  default     = false
  description = "If true, add Authorization header."
}

variable "enable_cors" {
  type        = bool
  default     = true
  description = "If true, enable CORS policy."
}

variable "enable_return_json" {
  type        = bool
  default     = true
  description = "If true, add Content-Type: application/json header to response."
}

variable "auth_token_attribute" {
  type        = string
  default     = "jwt_token_kong_rw"
  description = "Attribute of secret to auth token from."
}

variable "use_auth_token" {
  type = bool
  default = false
  description = "If true, kong plugin using JWT token the `Authorization: Bearer auth_token`"
}
variable "create_secret" {
  type    = bool
  default = true
}

variable "create_ingress_kong" {
  type    = bool
  default = true
  description = "If true, creating ingress."
}

variable "create_ingress_kong_ipfs" {
  type    = bool
  default = true
  description = "If true, creating ingress for ipfs."
}

variable "service_port_ipfs" {
  type    = string
  default = null
  description = "If provided , ingress for ipfs should be use service port for ipfs."
}

variable "http_path_ipfs" {
  type        = string
  default     = null
  description = "HTTP path to match."
}

variable "name" {
  type        = string
  default     = ""
  description = "Secret name."
}

variable "create_k8s_secret" {
  type        = bool
  default     = true
  description = "Create secret in Kubernetes."
}

variable "create_aws_secret" {
  type        = bool
  default     = true
  description = "Create secret in AWS."
}

variable "k8s_secret_postfix" {
  type        = string
  default     = "-lotus-secret"
  description = "Postfix of the Kubernetes secret."
}

variable "from_secret" {
  type        = string
  default     = ""
  description = "Secret to copy secret_string from."
}
