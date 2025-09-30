################## Public Mainnet Nodegroups #################

module "eks_nodegroup_ondemand_api_read_master_al2023" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name          = "api-read-master-al2023"
  instance_type = "r6gd.4xlarge"
  ami_type      = "AL2023_ARM_64_STANDARD"
  user_data     = "nvme-spot.sh"

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration

  root_volume_size = 150

  kubernetes_version = "1.30"
}

module "eks_nodegroup_ondemand_api_read_slave_0_al2023" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name          = "api-read-slave-0-al2023"
  instance_type = "r6gd.4xlarge"
  ami_type      = "AL2023_ARM_64_STANDARD"
  user_data     = "nvme-spot.sh"

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration

  root_volume_size = 150

  kubernetes_version = "1.30"
}

module "eks_nodegroup_ondemand_api_read_slave_1_al2023" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name          = "api-read-slave-1-al2023"
  instance_type = "r6gd.4xlarge"
  ami_type      = "AL2023_ARM_64_STANDARD"
  user_data     = "nvme-spot.sh"

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration

  root_volume_size = 150

  kubernetes_version = "1.30"
}

module "eks_nodegroup_ondemand_api_read_slave_2_al2023" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name          = "api-read-slave-2-al2023"
  instance_type = "r6gd.4xlarge"
  ami_type      = "AL2023_ARM_64_STANDARD"
  user_data     = "nvme-spot.sh"

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration

  root_volume_size = 150

  kubernetes_version = "1.30"
}

################## Public Calibnet Nodegroups ##################

module "eks_nodegroup_ondemand_calibnet_0_al2023" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name          = "calibnet-0-al2023"
  instance_type = "r6gd.xlarge"
  ami_type      = "AL2023_ARM_64_STANDARD"
  user_data     = "nvme-spot.sh"

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration

  kubernetes_version = "1.30"
}

module "eks_nodegroup_ondemand_calibnet_1_al2023" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name             = "calibnet-1-al2023"
  instance_type    = "r6gd.xlarge"
  ami_type         = "AL2023_ARM_64_STANDARD"
  is_spot_instance = true

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration

  root_volume_size = 80

  kubernetes_version = "1.30"
}

module "eks_nodegroup_ondemand_calibnet_2_al2023" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name             = "calibnet-2-al2023"
  instance_type    = "r6gd.2xlarge"
  ami_type         = "AL2023_ARM_64_STANDARD"
  is_spot_instance = true

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration

  root_volume_size = 80

  kubernetes_version = "1.31"
}

################## Mainnet Archive Nodegroups ##################

module "eks_nodegroup_ondemand_group19" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name          = "space07"
  instance_type = "r6g.16xlarge"
  ami_type      = "AL2023_ARM_64_STANDARD"
  is_critical   = true

  use_existing_ebs = true
  ebs_tenant       = "space07"

  custom_ebs_user_data = "ebs-udp.sh"

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration

  root_volume_size = 150

  kubernetes_version = "1.30"
}

module "eks_nodegroup_ondemand_fvm_archive" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name          = "fvm-archive"
  instance_type = "r6g.12xlarge"
  ami_type      = "AL2023_ARM_64_STANDARD"
  is_critical   = true

  use_existing_ebs = true
  ebs_tenant       = "fvm-archive"

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration

  root_volume_size = 150

  custom_ebs_user_data = "ebs-udp.sh"

  kubernetes_version = "1.30"
}

module "eks_nodegroup_ondemand_thegraph" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name          = "thegraph"
  instance_type = "r6g.8xlarge"
  ami_type      = "AL2023_ARM_64_STANDARD"
  is_critical   = true

  use_existing_ebs = true
  ebs_tenant       = "thegraph"

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration

  root_volume_size = 150

  custom_ebs_user_data = "ebs-udp.sh"

  kubernetes_version = "1.30"
}

################## Calibnet Archive Nodegroups ##################

module "eks_nodegroup_ondemand_group13" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name          = "calibration-archive"
  instance_type = "r6gd.4xlarge"
  ami_type      = "AL2023_ARM_64_STANDARD"
  user_data     = "nvme-spot.sh"

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration

  root_volume_size = 150

  kubernetes_version = "1.30"
}

################## Less Important Nodegroups ##################

module "eks_nodegroup_mainnet_ondemand_group6_al2023" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name          = "group6-al2023"
  ami_type      = "AL2023_x86_64_STANDARD"
  instance_type = "r5ad.2xlarge"

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration

  kubernetes_version = "1.30"
}

module "eks_nodegroup_cid_checker_spot_al2023" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name             = "cid_checker-al2023"
  ami_type         = "AL2023_x86_64_STANDARD"
  instance_type    = "r5ad.4xlarge,r5a.4xlarge"
  is_spot_instance = true

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration

  root_volume_size = 80

  kubernetes_version = "1.30"
}

module "eks_nodegroup_amd64_1_al2023" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name          = "amd64-1-al2023"
  ami_type      = "AL2023_x86_64_STANDARD"
  instance_type = "r5a.2xlarge"

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration

  root_volume_size = 256

  kubernetes_version = "1.30"
}
