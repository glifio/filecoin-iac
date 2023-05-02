#module "eks_nodegroup_api-read-test" {
#  count                                   = local.is_dev_envs
#  source                                  = "../modules/nodegroups"
#  get_instance_type                       = "m5d.8xlarge,r5ad.8xlarge"
#  get_nodegroup_name                      = "api-read-test" # don't need to type ondemand/spot in the name, it will be added automatically.
#  get_global_configuration                = local.make_global_configuration
#  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
#  namespace_secret                        = kubernetes_namespace_v1.network.metadata[0].name
#  exist_secret                            = data.aws_secretsmanager_secret_version.api_read_dev_lotus
#  is_spot_instance                        = true
#}