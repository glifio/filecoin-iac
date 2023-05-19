resource "helm_release" "kong" {
  name       = "default"
  repository = "https://charts.konghq.com"
  chart      = "kong"
  namespace  = kubernetes_namespace_v1.kong.metadata[0].name
  version    = "2.13.0"

  values = [file("${path.module}/config/kong/values.yaml")]

  set {
    name  = "replicaCount"
    value = 1
  }

  set {
    name  = "ingressController.ingressClass"
    value = "default"
  }
}
