################# START BLOCK ONDEMAND NODE-GROUP LIST #################

#prod-monitoring-Node
module "eks_nodegroup_mainnet_ondemand_group1" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name          = "group1"
  instance_type = "t3.large"

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration
}

#prod-api-i3-4x-ondemand-a-1-19-Node
module "eks_nodegroup_mainnet_ondemand_group6" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name          = "group6"
  instance_type = "r5ad.2xlarge"

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration
}


# ARM ONDEMAND NODES #
module "eks_nodegroup_ondemand_group13" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name          = "group13"
  instance_type = "r6gd.xlarge"
  ami_type      = "AL2_ARM_64"
  user_data     = "nvme-spot.sh"

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration

}

module "eks_nodegroup_ondemand_group16" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name          = "api-read-slave-0"
  instance_type = "r6gd.4xlarge"
  ami_type      = "AL2_ARM_64"
  user_data     = "nvme-spot.sh"

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration
}

module "eks_nodegroup_ondemand_group17" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name          = "api-read-slave-3"
  instance_type = "r6gd.4xlarge"
  ami_type      = "AL2_ARM_64"
  user_data     = "nvme-spot.sh"

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration
}

module "eks_nodegroup_ondemand_group18" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name          = "group18"
  instance_type = "r6gd.4xlarge"
  ami_type      = "AL2_ARM_64"
  user_data     = "nvme-spot.sh"

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration
}

module "eks_nodegroup_ondemand_group19" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name          = "space07"
  instance_type = "r6g.8xlarge"
  ami_type      = "AL2_ARM_64"
  is_critical   = true

  use_existing_ebs = true
  ebs_tenant       = "space07"

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration
}

#module "eks_nodegroup_ondemand_group28" {
#  count  = local.is_prod_envs
#  source = "../modules/eks_nodegroup"
#
#  name          = "group28"
#  instance_type = "r6gd.4xlarge"
#  ami_type      = "AL2_ARM_64"
#  user_data     = "nvme-spot.sh"
#
#  global_config    = local.make_global_configuration
#  nodegroup_config = local.make_eks_nodegroups_global_configuration
#}

module "eks_nodegroup_ondemand_group29" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name          = "space06"
  instance_type = "r6gd.8xlarge"
  ami_type      = "AL2_ARM_64"
  user_data     = "nvme-spot.sh"
  is_critical   = true

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration
}

module "eks_nodegroup_ondemand_fvm_archive" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name          = "fvm-archive"
  instance_type = "r6g.8xlarge"
  ami_type      = "AL2_ARM_64"
  is_critical   = true

  use_existing_ebs = true
  ebs_tenant       = "fvm-archive"

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration
}

module "eks_nodegroup_ondemand_calibnet_0" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name          = "calibnet-0"
  instance_type = "r6gd.xlarge"
  ami_type      = "AL2_ARM_64"
  user_data     = "nvme-spot.sh"

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration
}
################# END BLOCK ONDEMAND NODE-GROUP LIST #################


################# START BLOCK SPOT NODE-GROUP LIST #################

module "eks_nodegroup_spot_calibnet_1" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name             = "calibnet-1"
  instance_type    = "r6gd.xlarge"
  ami_type         = "AL2_ARM_64"
  is_spot_instance = true

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration
}

#prod-api-i3-4x8x-spot-b-1-19-Node
module "eks_nodegroup_mainnet_spot_group8" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name             = "api-read-slave-1"
  instance_type    = "r5ad.4xlarge"
  is_spot_instance = true

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration
}

##prod-api-i3-4x8x-spot-c-1-19-Node
module "eks_nodegroup_mainnet_spot_group9" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name             = "group9"
  instance_type    = "r6gd.4xlarge"
  ami_type         = "AL2_ARM_64"
  is_spot_instance = true

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration
}

#prod-space06-1-i3-2x4x-spot-a-1-19-Node
module "eks_nodegroup_mainnet_spot_group10" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name             = "group10"
  instance_type    = "r6gd.4xlarge"
  ami_type         = "AL2_ARM_64"
  is_spot_instance = true

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration
}

module "eks_nodegroup_cid_checker_spot" {
  count  = local.is_prod_envs
  source = "../modules/eks_nodegroup"

  name             = "cid_checker"
  instance_type    = "r5ad.4xlarge,r5a.4xlarge"
  is_spot_instance = true

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration
}

################# END BLOCK SPOT NODE-GROUP LIST #################
