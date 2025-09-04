################# START BLOCK ONDEMAND NODE-GROUP LIST #################

module "eks_nodegroup_ondemand_monitoring_dev_al2023" {
  count  = local.is_dev_envs
  source = "../modules/eks_nodegroup"

  name          = "monitoring-al2023" # don't need to type ondemand/spot in the name, it will be added automatically.
  instance_type = "t3.large"

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration

  kubernetes_version = "1.31"

  ami_type = "AL2023_x86_64_STANDARD"
}

################# END BLOCK ONDEMAND NODE-GROUP LIST #################


################# START BLOCK SPOT NODE-GROUP LIST #################

module "eks_nodegroup_spot_api_read_dev_al2023" {
  count  = local.is_dev_envs
  source = "../modules/eks_nodegroup"

  name             = "api-read-dev-al2023"
  instance_type    = "r6gd.xlarge"
  ami_type         = "AL2023_ARM_64_STANDARD"
  is_spot_instance = true
  root_volume_size = 80

  global_config    = local.make_global_configuration
  nodegroup_config = local.make_eks_nodegroups_global_configuration

  kubernetes_version = "1.31"
}

################# END BLOCK SPOT NODE-GROUP LIST #################
