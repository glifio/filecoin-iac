resource "helm_release" "monitoring" {
  name       = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = kubernetes_namespace_v1.monitoring.metadata[0].name
  version    = "36.6.2"

  values = [
    templatefile("${path.module}/configs/prometheus/values.yaml", {
      get_short_environment        = var.environment
      get_nodegroup_selector       = "group1"
      get_app_namespace            = kubernetes_namespace_v1.network.metadata[0].name
      get_slack_api_url            = lookup(jsondecode(data.aws_secretsmanager_secret_version.monitoring.secret_string), "slack_api_url", null)
      get_slack_channel            = lookup(jsondecode(data.aws_secretsmanager_secret_version.monitoring.secret_string), "slack_configs_0_channel", null)
      get_grafana_notifiers_url    = lookup(jsondecode(data.aws_secretsmanager_secret_version.monitoring.secret_string), "slack_api_url", null)
      get_prometheus_storage_class = kubernetes_storage_class_v1.ebs_csi_driver_gp2.metadata[0].name
      get_kong_ingress_external    = helm_release.konghq-external[0].name
      get_kong_ingress_internal    = helm_release.konghq-external[0].name //helm_release.konghq-internal[0].name
    })
  ]

  set {
    name  = "grafana.adminPassword"
    value = lookup(jsondecode(data.aws_secretsmanager_secret_version.monitoring.secret_string), "admin_password", null)
  }
}
