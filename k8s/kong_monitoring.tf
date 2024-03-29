resource "kubernetes_manifest" "kong_monitoring_plugin_external" {
  manifest = {
    apiVersion = "configuration.konghq.com/v1"
    kind       = "KongClusterPlugin"
    metadata = {
      name = "${terraform.workspace}-kong-monitoring-plugin-external"
      labels = {
        global = "true"
      }
      annotations = {
        "kubernetes.io/ingress.class" = "kong-external-lb"
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
