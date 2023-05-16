resource "kubernetes_manifest" "kong_monitoring_plugin" {
  manifest = {
    apiVersion = "configuration.konghq.com/v1"
    kind       = "KongClusterPlugin"
    metadata = {
      name = "kong-monitoring-default"
      labels = {
        global = "true"
      }
      annotations = {
        "kubernetes.io/ingress.class" = "default"
      }
    }

    config = {
      per_consumer            = true
      status_code_metrics     = true
      latency_metrics         = true
      bandwidth_metrics       = true
      upstream_health_metrics = true
    }

    plugin = "prometheus"
  }
}
