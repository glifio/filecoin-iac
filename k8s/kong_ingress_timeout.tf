# CRD for the KONG configuration. This is a service-level configuration.
# Hence, you will need to annotate your service resource in k8s with the configuration.konghq.com annotation.
# Links:
# https://github.com/Kong/kubernetes-ingress-controller/issues/905 - example with whole setup
# https://docs.konghq.com/kubernetes-ingress-controller/latest/references/custom-resources/#kongingress -
#   whole KongIngress config

resource "kubernetes_manifest" "kong_ingress_read_timeout" {
  count = local.is_mainnet_envs
  manifest = {
    "apiVersion" = "configuration.konghq.com/v1"
    "kind"       = "KongIngress"
    "metadata" = {
      "name"      = "kong-ingress-read-timeout"
      "namespace" = kubernetes_namespace_v1.network.metadata[0].name
      "annotations" = {
        "kubernetes.io/ingress.class" = "kong-external-lb"
      }
    }
    "proxy" = {
      "protocol"     = "http"
      "read_timeout" = 180000
    }
  }
}

resource "kubernetes_manifest" "kong_ingress_read_one_day_timeout" {
  count = local.is_mainnet_envs
  manifest = {
    "apiVersion" = "configuration.konghq.com/v1"
    "kind"       = "KongIngress"
    "metadata" = {
      "name"      = "kong-ingress-one-day-read-timeout"
      "namespace" = kubernetes_namespace_v1.network.metadata[0].name
      "annotations" = {
        "kubernetes.io/ingress.class" = "kong-external-lb"
      }
    }
    "proxy" = {
      "protocol"     = "http"
      "read_timeout" = 86400000
    }
  }
}
