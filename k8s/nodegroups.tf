# #this group is for future spot tests
module "eks_nodegroup_api-read-100" {
  count                                   = local.is_dev_envs
  source                                  = "../modules/nodegroups"
  ami_type                                = "AL2_ARM_64"
  get_instance_type                       = "r6gd.4xlarge"
  get_nodegroup_name                      = "api-read-100" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
  is_spot_instance                        = true

}