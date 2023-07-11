################# START BLOCK ONDEMAND NODE-GROUP LIST #################

#prod-monitoring-Node
module "eks_nodegroup_mainnet_ondemand_group1" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "t3.large"
  get_nodegroup_name                      = "group1" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
}

#prod-api-i3-4x-ondemand-a-1-19-Node
module "eks_nodegroup_mainnet_ondemand_group6" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "r5ad.2xlarge"
  get_nodegroup_name                      = "group6" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
}


# ARM ONDEMAND NODES #
module "eks_nodegroup_ondemand_group13" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  ami_type                                = "AL2_ARM_64"
  get_instance_type                       = "r6gd.xlarge"
  get_nodegroup_name                      = "group13" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
  user_data_script                        = "nvme-spot.sh"
}

module "eks_nodegroup_ondemand_group15" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  ami_type                                = "AL2_ARM_64"
  get_instance_type                       = "r6g.12xlarge"
  get_nodegroup_name                      = "group15" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
  use_existing_ebs                        = true
  ebs_tenant                              = "space00"
  assign_to_space00_07_nodes              = true
}

module "eks_nodegroup_ondemand_group16" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  ami_type                                = "AL2_ARM_64"
  get_instance_type                       = "r6gd.4xlarge"
  user_data_script                        = "nvme-spot.sh"
  get_nodegroup_name                      = "group16" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
}

module "eks_nodegroup_ondemand_group17" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  ami_type                                = "AL2_ARM_64"
  get_instance_type                       = "r6gd.4xlarge"
  user_data_script                        = "nvme-spot.sh"
  get_nodegroup_name                      = "group17" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
}

module "eks_nodegroup_ondemand_group18" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  ami_type                                = "AL2_ARM_64"
  get_instance_type                       = "r6gd.4xlarge"
  user_data_script                        = "nvme-spot.sh"
  get_nodegroup_name                      = "group18" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
}

module "eks_nodegroup_ondemand_group19" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  ami_type                                = "AL2_ARM_64"
  get_instance_type                       = "r6g.12xlarge"
  get_nodegroup_name                      = "group19" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
  use_existing_ebs                        = true
  ebs_tenant                              = "space07"
  assign_to_space00_07_nodes              = true
}

module "eks_nodegroup_ondemand_group28" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  ami_type                                = "AL2_ARM_64"
  get_instance_type                       = "r6gd.4xlarge"
  user_data_script                        = "nvme-spot.sh"
  get_nodegroup_name                      = "group28" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
}

module "eks_nodegroup_ondemand_group29" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  ami_type                                = "AL2_ARM_64"
  get_instance_type                       = "r6gd.4xlarge"
  user_data_script                        = "nvme-spot.sh"
  get_nodegroup_name                      = "group29" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
  assign_to_space00_07_nodes              = true
}

module "eks_nodegroup_ondemand_fvm_archive" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  ami_type                                = "AL2_ARM_64"
  get_instance_type                       = "r6g.12xlarge"
  get_nodegroup_name                      = "fvm-archive" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
  use_existing_ebs                        = true
  ebs_tenant                              = "fvm-archive"
  assign_to_space00_07_nodes              = true
}

module "eks_nodegroup_ondemand_confirm_0" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  ami_type                                = "AL2_ARM_64"
  get_instance_type                       = "r6gd.4xlarge"
  user_data_script                        = "nvme-spot.sh"
  get_nodegroup_name                      = "coinfirm-0" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
}

module "eks_nodegroup_ondemand_calibnet_0" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  ami_type                                = "AL2_ARM_64"
  get_instance_type                       = "c6g.4xlarge"
  user_data_script                        = "nvme-spot.sh"
  get_nodegroup_name                      = "calibnet-0" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
}

module "eks_nodegroup_ondemand_blockscout_0" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  ami_type                                = "AL2_ARM_64"
  get_instance_type                       = "r6gd.4xlarge"
  user_data_script                        = "nvme-spot.sh"
  get_nodegroup_name                      = "blockscout-0" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
}
################# END BLOCK ONDEMAND NODE-GROUP LIST #################


################# START BLOCK SPOT NODE-GROUP LIST #################

module "eks_nodegroup_spot_calibnet_1" {
  count                                   = local.is_prod_envs
  ami_type                                = "AL2_ARM_64"
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "c6g.4xlarge"       #r5ad.4xlarge for amd
  get_nodegroup_name                      = "calibnet-1" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
  is_spot_instance                        = true
}

#module "eks_nodegroup_spot_blockscout_1" {
#  count                                   = local.is_prod_envs
#  source                                  = "../modules/eks_nodegroup"
#  get_instance_type                       = "m5d.8xlarge,r5ad.8xlarge"
#  get_nodegroup_name                      = "blockscout-1" # don't need to type ondemand/spot in the name, it will be added automatically.
#  get_global_configuration                = local.make_global_configuration
#  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
#  is_spot_instance                        = true
#}

#module "eks_nodegroup_ondemand_confirm_1" {
#  count                                   = local.is_prod_envs
#  source                                  = "../modules/eks_nodegroup"
#  ami_type                                = "AL2_ARM_64"
#  get_instance_type                       = "r6g.12xlarge"
#  get_nodegroup_name                      = "coinfirm-1" # don't need to type ondemand/spot in the name, it will be added automatically.
#  get_global_configuration                = local.make_global_configuration
#  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
#  use_existing_ebs                        = true	
#  ebs_tenant                              = "coinfirm-1"	
#  assign_to_space00_07_nodes              = true
#}

#prod-api-i3-4x8x-spot-b-1-19-Node
module "eks_nodegroup_mainnet_spot_group8" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  ami_type                                = "AL2_ARM_64"
  get_instance_type                       = "r6gd.4xlarge" #m5d.8xlarge,r5ad.8xlarge for amd
  get_nodegroup_name                      = "group8" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
  is_spot_instance                        = true
}

##prod-api-i3-4x8x-spot-c-1-19-Node
module "eks_nodegroup_mainnet_spot_group9" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  ami_type                                = "AL2_ARM_64"
  get_instance_type                       = "r6gd.4xlarge"
  get_nodegroup_name                      = "group9" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
  is_spot_instance                        = true
}

#prod-space06-1-i3-2x4x-spot-a-1-19-Node
module "eks_nodegroup_mainnet_spot_group10" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  ami_type                                = "AL2_ARM_64"
  get_instance_type                       = "r6gd.4xlarge"
  get_nodegroup_name                      = "group10" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
  is_spot_instance                        = true
}

module "eks_nodegroup_cid_checker_spot" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "r5ad.4xlarge,r5a.4xlarge"
  get_nodegroup_name                      = "cid_checker" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
  is_spot_instance                        = true
}

################# END BLOCK SPOT NODE-GROUP LIST #################
