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

##prod-api-i3-4x-ondemand-a-1-19-Node
#module "eks_nodegroup_mainnet_ondemand_group2" {
#  count                                   = local.is_prod_envs
#  source                                  = "../modules/eks_nodegroup"
#  get_instance_type                       = "i3.4xlarge"
#  get_nodegroup_name                      = "group2" # don't need to type ondemand/spot in the name, it will be added automatically.
#  get_global_configuration                = local.make_global_configuration
#  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
#}

#prod-space06-ondemand-i3-4x-b-1-19-Node
#module "eks_nodegroup_mainnet_ondemand_group3" {
#  count                                   = local.is_prod_envs
#  source                                  = "../modules/eks_nodegroup"
#  get_instance_type                       = "i3.4xlarge"
#  get_nodegroup_name                      = "group3" # don't need to type ondemand/spot in the name, it will be added automatically.
#  get_global_configuration                = local.make_global_configuration
#  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
#}

#prod-ng-r5-8x-workers-ondemand-b-1-19-Node
#module "eks_nodegroup_mainnet_ondemand_group4" {
#  count                                   = local.is_prod_envs
#  source                                  = "../modules/eks_nodegroup"
#  get_instance_type                       = "r5b.12xlarge"
#  get_nodegroup_name                      = "group4" # don't need to type ondemand/spot in the name, it will be added automatically.
#  get_global_configuration                = local.make_global_configuration
#  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
#}

#prod-ng-r5-12x-workers-ondemand-a-1-19-Node
#module "eks_nodegroup_mainnet_ondemand_group5" {
#  count                                   = local.is_prod_envs
#  source                                  = "../modules/eks_nodegroup"
#  get_instance_type                       = "r5b.12xlarge"
#  get_nodegroup_name                      = "group5" # don't need to type ondemand/spot in the name, it will be added automatically.
#  get_global_configuration                = local.make_global_configuration
#  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
#  assign_to_space00_07_nodes              = true
#}

#prod-api-i3-4x-ondemand-a-1-19-Node
module "eks_nodegroup_mainnet_ondemand_group6" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "i3.4xlarge"
  get_nodegroup_name                      = "group6" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
}

#module "eks_nodegroup_mainnet_ondemand_group7" {
#  count                                   = local.is_prod_envs
#  source                                  = "../modules/eks_nodegroup"
#  get_instance_type                       = "i3.4xlarge"
#  get_nodegroup_name                      = "group7" # don't need to type ondemand/spot in the name, it will be added automatically.
#  get_global_configuration                = local.make_global_configuration
#  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
#}

#
#module "eks_nodegroup_ondemand_group11" {
#  count                                   = local.is_prod_envs
#  source                                  = "../modules/eks_nodegroup"
#  get_instance_type                       = "r5.2xlarge"
#  get_nodegroup_name                      = "group11" # don't need to type ondemand/spot in the name, it will be added automatically.
#  get_global_configuration                = local.make_global_configuration
#  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
#}
#
#module "eks_nodegroup_ondemand_group12" {
#  count                                   = local.is_prod_envs
#  source                                  = "../modules/eks_nodegroup"
#  get_instance_type                       = "r6gd.4xlarge"
#  get_nodegroup_name                      = "group12" # don't need to type ondemand/spot in the name, it will be added automatically.
#  get_global_configuration                = local.make_global_configuration
#  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
#}


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

module "eks_nodegroup_ondemand_group14" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  ami_type                                = "AL2_ARM_64"
  get_instance_type                       = "r6gd.xlarge"
  user_data_script                        = "nvme-spot.sh"
  get_nodegroup_name                      = "group14" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
}

module "eks_nodegroup_ondemand_group15" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  ami_type                                = "AL2_ARM_64"
  get_instance_type                       = "r6gd.12xlarge"
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
  get_instance_type                       = "r6gd.12xlarge"
  get_nodegroup_name                      = "group19" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
  use_existing_ebs                        = true
  ebs_tenant                              = "space07"
  assign_to_space00_07_nodes              = true
}

module "eks_nodegroup_ondemand_group20" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  ami_type                                = "AL2_ARM_64"
  get_instance_type                       = "r6gd.4xlarge"
  user_data_script                        = "nvme-spot.sh"
  get_nodegroup_name                      = "group20" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
}

module "eks_nodegroup_ondemand_group25" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  ami_type                                = "AL2_ARM_64"
  get_instance_type                       = "r6gd.4xlarge"
  user_data_script                        = "nvme-spot.sh"
  get_nodegroup_name                      = "group25" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
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

module "eks_nodegroup_ondemand_group34" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  ami_type                                = "AL2_ARM_64"
  get_instance_type                       = "r6gd.xlarge"
  get_nodegroup_name                      = "group34" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
  user_data_script                        = "nvme-spot.sh"
}

#module "eks_nodegroup_ondemand_fvm_archive" {
#  count                                   = local.is_prod_envs
#  source                                  = "../modules/eks_nodegroup"
#  ami_type                                = "AL2_ARM_64"
#  get_instance_type                       = "r6gd.12xlarge"
#  get_nodegroup_name                      = "fvm-archive" # don't need to type ondemand/spot in the name, it will be added automatically.
#  get_global_configuration                = local.make_global_configuration
#  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
#  use_existing_ebs                        = true
#  ebs_tenant                              = "fvm-archive"
#  assign_to_space00_07_nodes              = true
#}
################# END BLOCK ONDEMAND NODE-GROUP LIST #################


################# START BLOCK SPOT NODE-GROUP LIST #################

#prod-api-i3-4x8x-spot-b-1-19-Node
module "eks_nodegroup_mainnet_spot_group8" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "m5d.8xlarge,r5ad.8xlarge"
  get_nodegroup_name                      = "group8" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
  is_spot_instance                        = true
}

#prod-api-i3-4x8x-spot-c-1-19-Node
module "eks_nodegroup_mainnet_spot_group9" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "m5d.8xlarge,r5ad.8xlarge"
  get_nodegroup_name                      = "group9" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
  is_spot_instance                        = true
}

#prod-space06-1-i3-2x4x-spot-a-1-19-Node
module "eks_nodegroup_mainnet_spot_group10" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "m5d.8xlarge,r5ad.8xlarge"
  get_nodegroup_name                      = "group10" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
  is_spot_instance                        = true
}

# Temporary spot nodes for migration
module "eks_nodegroup_mainnet_spot_group21" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "m5d.8xlarge,r5ad.8xlarge"
  get_nodegroup_name                      = "group21" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
  is_spot_instance                        = true
}

# module "eks_nodegroup_mainnet_spot_group22" {
#   count                                   = local.is_prod_envs
#   source                                  = "../modules/eks_nodegroup"
#   get_instance_type                       = "m5d.8xlarge,r5ad.8xlarge"
#   get_nodegroup_name                      = "group22" # don't need to type ondemand/spot in the name, it will be added automatically.
#   get_global_configuration                = local.make_global_configuration
#   get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
#   is_spot_instance                        = true
# }

# module "eks_nodegroup_mainnet_spot_group23" {
#   count                                   = local.is_prod_envs
#   source                                  = "../modules/eks_nodegroup"
#   get_instance_type                       = "m5d.8xlarge,r5ad.8xlarge"
#   get_nodegroup_name                      = "group23" # don't need to type ondemand/spot in the name, it will be added automatically.
#   get_global_configuration                = local.make_global_configuration
#   get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
#   is_spot_instance                        = true
# }

#module "eks_nodegroup_mainnet_spot_group24" {
#  count                                   = local.is_prod_envs
#  source                                  = "../modules/eks_nodegroup"
#  get_instance_type                       = "m5d.8xlarge,r5ad.8xlarge"
#  get_nodegroup_name                      = "group24" # don't need to type ondemand/spot in the name, it will be added automatically.
#  get_global_configuration                = local.make_global_configuration
#  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
#  is_spot_instance                        = true
#}

#module "eks_nodegroup_mainnet_spot_group26" {
#  count                                   = local.is_prod_envs
#  source                                  = "../modules/eks_nodegroup"
#  get_instance_type                       = "m5d.8xlarge,r5ad.8xlarge"
#  get_nodegroup_name                      = "group26" # don't need to type ondemand/spot in the name, it will be added automatically.
#  get_global_configuration                = local.make_global_configuration
#  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
#  is_spot_instance                        = true
#}
#
#module "eks_nodegroup_mainnet_spot_group27" {
#  count                                   = local.is_prod_envs
#  source                                  = "../modules/eks_nodegroup"
#  get_instance_type                       = "m5d.8xlarge,r5ad.8xlarge"
#  get_nodegroup_name                      = "group27" # don't need to type ondemand/spot in the name, it will be added automatically.
#  get_global_configuration                = local.make_global_configuration
#  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
#  is_spot_instance                        = true
#}

# Use this node for mirrors
#module "eks_nodegroup_mainnet_spot_group30" {
#  count                                   = local.is_prod_envs
#  source                                  = "../modules/eks_nodegroup"
#  get_instance_type                       = "m5d.8xlarge,r5ad.8xlarge"
#  get_nodegroup_name                      = "group30" # don't need to type ondemand/spot in the name, it will be added automatically.
#  get_global_configuration                = local.make_global_configuration
#  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
#  is_spot_instance                        = true
#}
#
#module "eks_nodegroup_mainnet_spot_group35" {
#  count                                   = local.is_prod_envs
#  source                                  = "../modules/eks_nodegroup"
#  get_instance_type                       = "m5d.8xlarge,r5ad.8xlarge"
#  get_nodegroup_name                      = "group35" # don't need to type ondemand/spot in the name, it will be added automatically.
#  get_global_configuration                = local.make_global_configuration
#  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
#  is_spot_instance                        = true
#}

# Use these nodes for canary releases
# module "eks_nodegroup_mainnet_spot_group31" {
#   count                                   = local.is_prod_envs
#   source                                  = "../modules/eks_nodegroup"
#   get_instance_type                       = "m5d.8xlarge,r5ad.8xlarge"
#   get_nodegroup_name                      = "group31" # don't need to type ondemand/spot in the name, it will be added automatically.
#   get_global_configuration                = local.make_global_configuration
#   get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
#   is_spot_instance                        = true
# }

#module "eks_nodegroup_mainnet_spot_group32" {
#  count                                   = local.is_prod_envs
#  source                                  = "../modules/eks_nodegroup"
#  get_instance_type                       = "m5d.8xlarge,r5ad.8xlarge"
#  get_nodegroup_name                      = "group32" # don't need to type ondemand/spot in the name, it will be added automatically.
#  get_global_configuration                = local.make_global_configuration
#  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
#  is_spot_instance                        = true
#}
#
#module "eks_nodegroup_mainnet_spot_group33" {
#  count                                   = local.is_prod_envs
#  source                                  = "../modules/eks_nodegroup"
#  get_instance_type                       = "m5d.8xlarge,r5ad.8xlarge"
#  get_nodegroup_name                      = "group33" # don't need to type ondemand/spot in the name, it will be added automatically.
#  get_global_configuration                = local.make_global_configuration
#  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
#  is_spot_instance                        = true
#}

################# END BLOCK SPOT NODE-GROUP LIST #################
