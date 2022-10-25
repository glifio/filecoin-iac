resource "kubernetes_manifest" "kong_monitoring_plugin" {
  manifest = {
    apiVersion = "configuration.konghq.com/v1"
    kind = "KongClusterPlugin"
    metadata = {
        name = "${terraform.workspace}-kong-monitoring-plugin"
        labels = {
            global = "true"
        }
    }
    plugin = "prometheus"
  }
}