################# START BLOCK ONDEMAND NODE-GROUP LIST #################

module "eks_nodegroup_ondemand_monitoring_dev" {
  count                                   = local.is_dev_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "t3.large"
  get_nodegroup_name                      = "monitoring" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration

  custom_labels = {
    nodepool = "monitoring"
  }
}

module "eks_nodegroup_ondemand_api_read_dev_db" {
  count                                   = local.is_dev_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "i4i.2xlarge"
  user_data_script                        = "yugabutedb.sh"
  get_nodegroup_name                      = "api-read-dev-db" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration

  get_max_size     = 5
  get_desired_size = 0
  get_min_size     = 0

  custom_labels = {
    app     = "api-read-dev"
    purpose = "db"
  }
}

################# END BLOCK ONDEMAND NODE-GROUP LIST #################


################# START BLOCK SPOT NODE-GROUP LIST #################

module "eks_nodegroup_spot_group2" {
  count                                   = local.is_dev_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "r5ad.2xlarge"
  get_nodegroup_name                      = "group2" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration

  get_min_size = 0
  get_desired_size = 0

  is_spot_instance = true
}

module "eks_nodegroup_spot_api_read_dev_workers" {
  count                                   = local.is_dev_envs
  source                                  = "../modules/eks_nodegroup"
  get_instance_type                       = "r5ad.2xlarge"
  get_nodegroup_name                      = "api-read-dev-worker" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration

  is_spot_instance = true

  get_max_size     = 5
  get_desired_size = 0
  get_min_size = 0

  custom_labels = {
    app     = "api-read-dev"
    purpose = "worker"
  }
}

################# END BLOCK SPOT NODE-GROUP LIST #################
