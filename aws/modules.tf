module "generator" {
  source          = "../modules/generator"
  project         = var.project
  region          = var.region
  environment     = var.environment
  sub_environment = var.sub_environment
}

module "eks_nodegroup_ondemand_group1" {
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "t3.large"
  get_nodegroup_name                      = "group1" # don't need to type ondemand in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
}

module "eks_nodegroup_spot_group2" {
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "i3.2xlarge"
  get_nodegroup_name                      = "group2" # don't need to type ondemand in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
  is_spot_instance                        = true
}

module "eks_nodegroup_ondemand_group3" {
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "r5.2xlarge"
  get_nodegroup_name                      = "group3" # don't need to type ondemand in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
}

module "eks_nodegroup_ondemand_group4" {
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "r5.2xlarge"
  get_nodegroup_name                      = "group4" # don't need to type ondemand in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
}
