################# START BLOCK ONDEMAND NODE-GROUP LIST #################

module "eks_nodegroup_ondemand_group1" {
  count                                   = local.is_dev_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "t3.large"
  get_nodegroup_name                      = "group1" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
}

################# END BLOCK ONDEMAND NODE-GROUP LIST #################


################# START BLOCK SPOT NODE-GROUP LIST #################

module "eks_nodegroup_spot_group2" {
  count                                   = local.is_dev_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "r5dn.4xlarge"
  get_nodegroup_name                      = "group2" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
  is_spot_instance                        = true
}

 #this group is for future spot tests
## module "eks_nodegroup_spot_group5" {
#   count                                   = local.is_dev_envs
#   source                                  = "../modules/eks_nodegroup"
#   ami_type                                = "AL2_ARM_64"
#   get_instance_type                       = "r6gd.4xlarge"
#   get_nodegroup_name                      = "group5" # don't need to type ondemand/spot in the name, it will be added automatically.
#   get_global_configuration                = local.make_global_configuration
#   get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
#   is_spot_instance                        = true
# }

################# END BLOCK SPOT NODE-GROUP LIST #################
