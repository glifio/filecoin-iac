# Setup for the p2p port on the space00 pod
# Example of config creation https://docs.konghq.com/kubernetes-ingress-controller/latest/guides/using-tcpingress/
# Upstream creation is done via helm chart values - proxy.stream[0].containerPort, proxy.stream[0].servicePort,
#   proxy.stream[0].protocol
# Warning: you need to place your TCPIngress CRD into the same namespace with the target service!

resource "kubernetes_manifest" "kong_tcp_ingress" {
  count = local.is_prod_envs
  manifest = {
    apiVersion = "configuration.konghq.com/v1beta1"
    kind       = "TCPIngress"

    metadata = {
      name      = "${terraform.workspace}-space00-1235"
      namespace = kubernetes_namespace_v1.network.metadata[0].name
      annotations = {
        "kubernetes.io/ingress.class" : "kong-external-lb"
      }
    }
    spec = {
      rules = [{
        port = 1235
        backend = {
          serviceName = "space00-lotus-service"
          servicePort = 1235
        }
      }]
    }
  }
}


resource "kubernetes_manifest" "kong_tcp_ingress_space07" {
  count = local.is_prod_envs
  manifest = {
    apiVersion = "configuration.konghq.com/v1beta1"
    kind       = "TCPIngress"

    metadata = {
      name      = "${terraform.workspace}-space07-1236"
      namespace = kubernetes_namespace_v1.network.metadata[0].name
      annotations = {
        "kubernetes.io/ingress.class" : "kong-external-lb"
      }
    }
    spec = {
      rules = [{
        port = 1236
        backend = {
          serviceName = "space07-lotus-service"
          servicePort = 1236
        }
      }]
    }
  }
}


resource "kubernetes_manifest" "kong_tcp_ingress_calibration_archive" {
  count = local.is_prod_envs
  manifest = {
    apiVersion = "configuration.konghq.com/v1beta1"
    kind       = "TCPIngress"

    metadata = {
      name      = "${terraform.workspace}-calibration-archive-1237"
      namespace = kubernetes_namespace_v1.network.metadata[0].name
      annotations = {
        "kubernetes.io/ingress.class" : "kong-external-lb"
      }
    }
    spec = {
      rules = [{
        port = 1237
        backend = {
          serviceName = "calibrationapi-archive-node-lotus-service"
          servicePort = 1237
        }
      }]
    }
  }
}
