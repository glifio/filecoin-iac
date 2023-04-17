# https://docs.konghq.com/kubernetes-ingress-controller/latest/deployment/eks/

resource "helm_release" "konghq-external" {
  name       = "${module.generator.prefix}-kong-external"
  repository = "https://charts.konghq.com"
  chart      = "kong"
  namespace  = kubernetes_namespace_v1.kong.metadata[0].name
  version    = "2.13.0"

  values = [templatefile("${path.module}/configs/konghq/external.yaml", {
    app                        = "${module.generator.prefix}-kong-external"
    http_mirror_configmap_name = kubernetes_config_map.kong_plugin-http_mirror.metadata[0].name
  })]

  set {
    name  = "replicaCount"
    value = 4
  }

  set {
    name  = "ingressController.ingressClass"
    value = "kong-external-lb"
  }

  set {
    name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-cert"
    value = aws_acm_certificate.external_lb.arn
  }
}

resource "helm_release" "konghq-mirror" {
  name       = "${module.generator.prefix}-kong-mirror-1"
  repository = "https://charts.konghq.com"
  chart      = "kong"
  namespace  = kubernetes_namespace_v1.kong.metadata[0].name
  version    = "2.13.0"

  values = [templatefile("${path.module}/configs/konghq/external.yaml", {
    app                        = "${module.generator.prefix}-kong-mirror-1"
    http_mirror_configmap_name = kubernetes_config_map.kong_plugin-http_mirror.metadata[0].name
  })]

  set {
    name  = "replicaCount"
    value = 4
  }

  set {
    name  = "ingressController.ingressClass"
    value = "kong-mirror-lb"
  }

  set {
    name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-cert"
    value = aws_acm_certificate.external_lb.arn
  }
}

resource "helm_release" "konghq-mirror2" {
  name       = "${module.generator.prefix}-kong-mirror-2"
  repository = "https://charts.konghq.com"
  chart      = "kong"
  namespace  = kubernetes_namespace_v1.kong.metadata[0].name
  version    = "2.13.0"

  values = [templatefile("${path.module}/configs/konghq/external.yaml", {
    app                        = "${module.generator.prefix}-kong-mirror-2"
    http_mirror_configmap_name = kubernetes_config_map.kong_plugin-http_mirror.metadata[0].name
  })]

  set {
    name  = "replicaCount"
    value = 4
  }

  set {
    name  = "ingressController.ingressClass"
    value = "kong-mirror2-lb"
  }

  set {
    name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-cert"
    value = aws_acm_certificate.external_lb.arn
  }
}

resource "helm_release" "konghq-internal" {
  name       = "${module.generator.prefix}-kong-internal"
  repository = "https://charts.konghq.com"
  chart      = "kong"
  namespace  = kubernetes_namespace_v1.kong.metadata[0].name
  version    = "2.10.2"

  values = [templatefile("${path.module}/configs/konghq/internal.yaml", {
    app = "${module.generator.prefix}-kong-internal"
  })]

  set {
    name  = "replicaCount"
    value = 2
  }
  set {
    name  = "ingressController.ingressClass"
    value = "kong-internal-lb"
  }

  set {
    name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-cert"
    value = aws_acm_certificate.internal_lb.arn
  }
}
