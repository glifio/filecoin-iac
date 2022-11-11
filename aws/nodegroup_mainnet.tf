################# START BLOCK ONDEMAND NODE-GROUP LIST #################

#prod-monitoring-Node
module "eks_nodegroup_mainnet_ondemand_group1" {
  count                                   = local.is_mainnet_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "t3.large"
  get_nodegroup_name                      = "group1" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
}

#prod-api-i3-4x-ondemand-a-1-19-Node
module "eks_nodegroup_mainnet_ondemand_group2" {
  count                                   = local.is_mainnet_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "i3.4xlarge"
  get_nodegroup_name                      = "group2" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
}

#prod-space06-ondemand-i3-4x-b-1-19-Node
module "eks_nodegroup_mainnet_ondemand_group3" {
  count                                   = local.is_mainnet_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "i3.4xlarge"
  get_nodegroup_name                      = "group3" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
}

#prod-ng-r5-8x-workers-ondemand-b-1-19-Node
module "eks_nodegroup_mainnet_ondemand_group4" {
  count                                   = local.is_mainnet_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "r5b.8xlarge"
  get_nodegroup_name                      = "group4" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
}

#prod-ng-r5-12x-workers-ondemand-a-1-19-Node
module "eks_nodegroup_mainnet_ondemand_group5" {
  count                                   = local.is_mainnet_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "r5b.12xlarge"
  get_nodegroup_name                      = "group5" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
  assign_pods_to_key_nodes                = true
}

#prod-api-i3-4x-ondemand-a-1-19-Node
module "eks_nodegroup_mainnet_ondemand_group6" {
  count                                   = local.is_mainnet_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "i3.4xlarge"
  get_nodegroup_name                      = "group6" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
}

module "eks_nodegroup_mainnet_ondemand_group7" {
  count                                   = local.is_mainnet_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "i3.4xlarge"
  get_nodegroup_name                      = "group7" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
  assign_pods_to_key_nodes                = true
}

################# END BLOCK ONDEMAND NODE-GROUP LIST #################


################# START BLOCK SPOT NODE-GROUP LIST #################

#prod-api-i3-4x8x-spot-b-1-19-Node
module "eks_nodegroup_mainnet_spot_group8" {
  count                                   = local.is_mainnet_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "i3.4xlarge"
  get_nodegroup_name                      = "group8" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
  is_spot_instance                        = true
}

#prod-api-i3-4x8x-spot-c-1-19-Node
module "eks_nodegroup_mainnet_spot_group9" {
  count                                   = local.is_mainnet_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "i3.4xlarge"
  get_nodegroup_name                      = "group9" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
  is_spot_instance                        = true
}

#prod-space06-1-i3-2x4x-spot-a-1-19-Node
module "eks_nodegroup_mainnet_spot_group10" {
  count                                   = local.is_mainnet_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "i3.2xlarge"
  get_nodegroup_name                      = "group10" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
  is_spot_instance                        = true
}

################# END BLOCK SPOT NODE-GROUP LIST #################
