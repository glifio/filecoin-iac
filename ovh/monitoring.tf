resource "helm_release" "monitoring" {
  name       = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = kubernetes_namespace_v1.monitoring.metadata[0].name
  version    = "36.6.2"

  values = [templatefile("${path.module}/config/prometheus/values.yaml", {
    slack_channel = local.monitoring.slack.channel,
    slack_api_url = local.monitoring.slack.api_url,
    domain_name   = local.monitoring.domain_name,
    pvc_size      = local.monitoring.pvc_size
  })]

  set {
    name  = "grafana.adminPassword"
    value = lookup(jsondecode(data.aws_secretsmanager_secret_version.monitoring.secret_string), "admin_password", null)
  }
}
