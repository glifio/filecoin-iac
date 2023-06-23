variable "get_global_configuration" {
  description = "Set of inputs used by module generator for the naming."
}
variable "get_eks_nodegroups_global_configuration" {
  description = "Set of basic inputs  to EKS cluster and networking settings."
}
variable "get_instance_type" {
  type    = string
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

variable "assign_to_space00_07_nodes" {
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
