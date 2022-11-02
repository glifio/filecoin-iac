resource "kubernetes_manifest" "kong_monitoring_plugin_external" {
  manifest = {
    apiVersion = "configuration.konghq.com/v1"
    kind = "KongClusterPlugin"
    metadata = {
        name = "${terraform.workspace}-kong-monitoring-plugin-external"
        labels = {
            global = "true"
        }
        annotations = {
            "kubernetes.io/ingress.class" = "kong-external-lb"
        }
    }

    plugin = "prometheus"
  }
}

resource "kubernetes_manifest" "kong_monitoring_plugin_internal" {
  manifest = {
    apiVersion = "configuration.konghq.com/v1"
    kind = "KongClusterPlugin"
    metadata = {
        name = "${terraform.workspace}-kong-monitoring-plugin-internal"
        labels = {
            global = "true"
        }
        annotations = {
            "kubernetes.io/ingress.class" = "kong-internal-lb"
        }
    }

    plugin = "prometheus"
  }
}