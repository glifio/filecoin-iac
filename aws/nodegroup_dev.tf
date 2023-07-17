################# START BLOCK ONDEMAND NODE-GROUP LIST #################

module "eks_nodegroup_ondemand_group1" {
  count  = local.is_dev_envs
  source = "../modules/eks_nodegroup"

  name          = "group1" # don't need to type ondemand/spot in the name, it will be added automatically.
  instance_type = "t3.large"

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration
}

################# END BLOCK ONDEMAND NODE-GROUP LIST #################


################# START BLOCK SPOT NODE-GROUP LIST #################

module "eks_nodegroup_spot_group2" {
  count  = local.is_dev_envs
  source = "../modules/eks_nodegroup"

  name             = "group2" # don't need to type ondemand/spot in the name, it will be added automatically.
  instance_type    = "r5dn.4xlarge"
  is_spot_instance = true

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration
}

################# END BLOCK SPOT NODE-GROUP LIST #################
