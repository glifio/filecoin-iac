#module "eks_nodegroup_api-read-group1" {
#  count                                   = local.is_dev_envs
#  source                                  = "../modules/nodegroups"
#  get_instance_type                       = "m5d.8xlarge,r5ad.8xlarge"
#  get_nodegroup_name                      = "api-read-group1" # don't need to type ondemand/spot in the name, it will be added automatically.
#  get_global_configuration                = local.make_global_configuration
#  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
#  get_namespace                           = kubernetes_namespace_v1.network.metadata[0].name
#  exist_secret                            = data.aws_secretsmanager_secret_version.api_read_dev_lotus
#  is_spot_instance                        = true
#
#  get_ingress_backend_service_port        = 1234
#  get_rule_host                           = "dev-internal.dev.node.glif.io"
#  type_lb_scheme                          = "internal"
#  is_kong_auth_header_block_public_access = false
#
#  zone_id         = data.aws_route53_zone.node_glif_io.zone_id
#  records         = [data.aws_lb.kong_external.dns_name]
#}
