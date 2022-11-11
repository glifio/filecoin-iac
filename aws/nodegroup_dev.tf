################# START BLOCK ONDEMAND NODE-GROUP LIST #################

module "eks_nodegroup_ondemand_group1" {
  count                                   = local.is_dev_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "t3.large"
  get_nodegroup_name                      = "group1" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
  assign_pods_to_key_nodes                = true
}

module "eks_nodegroup_ondemand_group3" {
  count                                   = local.is_dev_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "r5.2xlarge"
  get_nodegroup_name                      = "group3" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
}

module "eks_nodegroup_ondemand_group4" {
  count                                   = local.is_dev_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "r5.2xlarge"
  get_nodegroup_name                      = "group4" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
}

################# END BLOCK ONDEMAND NODE-GROUP LIST #################


################# START BLOCK SPOT NODE-GROUP LIST #################

module "eks_nodegroup_spot_group2" {
  count                                   = local.is_dev_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "i3.2xlarge"
  get_nodegroup_name                      = "group2" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
  is_spot_instance                        = true
}

################# END BLOCK SPOT NODE-GROUP LIST #################
