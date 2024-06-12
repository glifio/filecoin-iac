# https://docs.konghq.com/kubernetes-ingress-controller/latest/deployment/eks/

resource "helm_release" "konghq-external" {
  name       = "${module.generator.prefix}-kong-external"
  repository = "https://charts.konghq.com"
  chart      = "kong"
  namespace  = kubernetes_namespace_v1.kong.metadata[0].name
  version    = "2.13.0"

  values = [templatefile("${path.module}/configs/konghq/values.tftpl", {
    name    = "${module.generator.prefix}-kong-external",
    crt_arn = aws_acm_certificate.external_lb.arn,

    additional_ports = [1235, 1236, 1237],

    plugins = [
      {
        name    = "http-mirror",
        cm_name = kubernetes_config_map.kong_plugin-http_mirror.metadata[0].name
      },
      {
        name    = "external-auth",
        cm_name = kubernetes_config_map.kong_plugin-external_auth.metadata[0].name
      }
    ]
  })]

  set {
    name  = "ingressController.image.tag"
    value = "2.8"
  }

  set {
    name  = "replicaCount"
    value = local.kong_external_replicas
  }

  set {
    name  = "ingressController.ingressClass"
    value = "kong-external-lb"
  }
}
