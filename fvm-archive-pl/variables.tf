variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "aws_profile" {
  type    = string
  default = "filecoin"
}

variable "resource_prefix" {
  type    = string
  default = "apn1-production-fvm-archive-pl"
}

variable "common_tags" {
  type = map(string)
  default = {
    Project         = "Filecoin"
    Environment     = "mainnet"
    Sub_environment = "glif"
    ProvisionedWith = "Terraform"
  }
}

variable "vpc_tags" {
  type = map(string)
  default = {
    Name = "filecoin-mainnet-apn1-glif-vpc"
  }
}

variable "subnet_tags" {
  type = map(string)
  default = {
    Name = "filecoin-mainnet-apn1-glif-public-0"
  }
}

variable "instance_type" {
  type    = string
  default = "r6g.8xlarge"
}

variable "public_key" {
  type    = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHMC7lI58Is6qjyARyNAJw9jm/LWcmjXsIZL5t2urMcl common glif"
}

variable "root_volume_size" {
  type    = number
  default = 120
}
