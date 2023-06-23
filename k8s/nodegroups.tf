#module "eks_nodegroup_api-read-group14" {
#  count                                   = local.is_dev_envs
#  source                                  = "../modules/nodegroups"
#  get_instance_type                       = "m5d.8xlarge,r5ad.8xlarge"
#  get_nodegroup_name                      = "api-read-group14" # don't need to type ondemand/spot in the name, it will be added automatically.
#  get_global_configuration                = local.make_global_configuration
#  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
#  get_namespace                           = kubernetes_namespace_v1.network.metadata[0].name
#  is_spot_instance                        = true
#

# create_secret

#  # create ingress for http #
#
#  http_host                               = "test.dev.node.glif.io"
#  http_path                               = "/api-read-group14/lotus/(.*)"
#  service_port                            = 1234
#
#
#  # create ingress for ipfs  #
#
#  create_ingress_kong_ipfs              = false
#  http_path_ipfs                        = "/api-read-group14/ipfs/4001/(.*)"
#  service_port_ipfs                     = 4001
#
#