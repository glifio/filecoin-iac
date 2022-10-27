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

    config = {
        per_consumer = true
        status_code_metrics = true
        latency_metrics = true
        bandwidth_metrics = true
        upstream_health_metrics = true
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

    config = {
        per_consumer = true
        status_code_metrics = true
        latency_metrics = true
        bandwidth_metrics = true
        upstream_health_metrics = true
    }

    plugin = "prometheus"
  }
}



resource "kubernetes_service" "kong_monitoring_service" {
    metadata {
        name = "${terraform.workspace}-kong-monitoring-service"
        namespace = kubernetes_namespace_v1.kong.metadata[0].name
        labels = {
            app = "kong-monitoring-service"
        }
    }

    spec {
        selector = {
            "app.kubernetes.io/name" = "kong"
        }

        port {
            name = "metrics"
            port = 8100
            target_port = 8100
        }

        type = "ClusterIP"
    }
}