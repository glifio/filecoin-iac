# https://docs.konghq.com/kubernetes-ingress-controller/latest/guides/using-tcpingress/
# Setup for the p2p port on the space00 pod

resource "kubernetes_manifest" "kong_tcp_ingress" {
  manifest = {
    apiVersion = "configuration.konghq.com/v1beta1"
    kind       = "TCPIngress"

    metadata = {
      name      = "space00-1235"
      namespace = kubernetes_namespace_v1.kong.metadata[0].name
      annotations = {
        "kubernetes.io/ingress.class" : "kong-external"
      }
    }
    spec = {
      rules = [{
        port = 1235
        backend = {
          serviceName = "${kubernetes_namespace_v1.network.metadata[0].name}/space00-lotus-service"
          servicePort = 1235
        }
      }]
    }
  }
}
