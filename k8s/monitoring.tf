# TODO: probably, we should move this code to module, 'cause it will be easier to customize values and remaing defaults,
#  but for now, I believe it will be enough and not critical

# WARNING: `get_pvc_size` variable wouldn't resize your pvc and
#   will work only on installation of the monitoring helm chart
# Mitigation: monitoring pvcs with https://grafana.com/grafana/dashboards/17092-kubernetes-persistent-volumes/ and 
#   notify after usage of more then 80%
# Workaround: please do resize via `kubectl edit pvc`
# Issue: https://github.com/prometheus-community/helm-charts/issues/957
# ---
# Idea: Probably this is how pvc are working in k8s, if you interested you can go deeper in the k8s and csi,
#   for me it was onetime task:
# Docu: https://kubernetes.io/docs/concepts/storage/persistent-volumes/#expanding-persistent-volumes-claims
resource "helm_release" "monitoring" {
  name       = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = kubernetes_namespace_v1.monitoring.metadata[0].name
  version    = "36.6.2"

  values = [
    templatefile("${path.module}/configs/prometheus/values.yaml", {
      get_short_environment        = var.environment
      get_nodegroup_selector       = local.monitoring_nodegroups
      get_app_namespace            = kubernetes_namespace_v1.network.metadata[0].name
      get_slack_api_url            = lookup(jsondecode(data.aws_secretsmanager_secret_version.monitoring.secret_string), "slack_api_url", null)
      get_slack_channel            = lookup(jsondecode(data.aws_secretsmanager_secret_version.monitoring.secret_string), "slack_configs_0_channel", null)
      get_grafana_notifiers_url    = lookup(jsondecode(data.aws_secretsmanager_secret_version.monitoring.secret_string), "slack_api_url", null)
      get_prometheus_storage_class = kubernetes_storage_class_v1.ebs_csi_driver_gp2.metadata[0].name
      get_kong_ingress_external    = helm_release.konghq-external.name
      get_kong_ingress_internal    = helm_release.konghq-internal.name
      get_grafana_notif_url        = local.is_dev_envs == 1 ? "monitoring.dev.node.glif.io" : "monitoring.node.glif.io"
      get_pvc_size                 = local.is_dev_envs == 1 ? "100Gi" : "265Gi"
      users                        = jsondecode(data.aws_secretsmanager_secret_version.credentials-grafana-users.secret_string)
    })
  ]

  set {
    name  = "grafana.adminPassword"
    value = lookup(jsondecode(data.aws_secretsmanager_secret_version.monitoring.secret_string), "admin_password", null)
  }
}
