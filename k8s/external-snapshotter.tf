resource "helm_release" "external-snapshotter" {
  count      = local.is_prod_envs
  name       = "external-snapshotter"
  repository = "oci://${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com"
  chart      = "${module.generator.prefix}-chart-external-snapshotter"
  namespace  = "kube-system"
  version    = "0.1.0"
}
