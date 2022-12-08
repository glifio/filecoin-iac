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
  type = string
  default = "nvme.sh"
}
