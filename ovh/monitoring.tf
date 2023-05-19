resource "helm_release" "monitoring" {
  name       = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = kubernetes_namespace_v1.monitoring.metadata[0].name
  version    = "36.6.2"

  values = [
    file("${path.module}/config/prometheus/general.yaml"),
    file("${path.module}/config/prometheus/dashboards.yaml"),
    file("${path.module}/config/prometheus/monitors.yaml"),
    file("${path.module}/config/prometheus/notification-template.yaml"),

    templatefile("${path.module}/config/prometheus/prometheus.yaml", {
      pvc_size = local.monitoring.pvc_size
    }),

    templatefile("${path.module}/config/prometheus/grafana.yaml", {
      domain_name   = local.monitoring.domain_name,
      slack_api_url = local.monitoring.slack.api_url
    }),

    templatefile("${path.module}/config/prometheus/alert-manager.yaml", {
      slack_api_url = local.monitoring.slack.api_url,
      slack_channel = local.monitoring.slack.channel
    })
  ]

  set {
    name  = "grafana.adminPassword"
    value = lookup(jsondecode(data.aws_secretsmanager_secret_version.monitoring.secret_string), "admin_password", null)
  }
}
