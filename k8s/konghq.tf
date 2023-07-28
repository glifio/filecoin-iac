# https://docs.konghq.com/kubernetes-ingress-controller/latest/deployment/eks/

resource "helm_release" "konghq-external" {
  name       = "${module.generator.prefix}-kong-external"
  repository = "https://charts.konghq.com"
  chart      = "kong"
  namespace  = kubernetes_namespace_v1.kong.metadata[0].name
  version    = "2.13.0"

  values = [templatefile("${path.module}/configs/konghq/values.yaml", {
    app                        = "${module.generator.prefix}-kong-external"
    http_mirror_configmap_name = kubernetes_config_map.kong_plugin-http_mirror.metadata[0].name
  })]

  set {
    name  = "ingressController.image.tag"
    value = "2.8"
  }

  set {
    name  = "replicaCount"
    value = 4
  }

  set {
    name  = "ingressController.ingressClass"
    value = "kong-external-lb"
  }

  set {
    name  = "proxy.tls.overrideServiceTargetPort"
    value = "8000"
  }

  set {
    name  = "ingressController.ingressClassAnnotations.ingressclass\\.kubernetes\\.io/is-default-class"
    value = "true"
  }

  set {
    name  = "ingressController.installCRDs"
    value = "false"
  }

  set {
    name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
    value = "nlb"
  }

  set {
    name  = "proxy.externalTrafficPolicy"
    value = "Local"
  }

  set {
    name  = "proxy.internalTrafficPolicy"
    value = "Local"
  }

  set {
    name  = "proxy.stream[0].containerPort"
    value = "1235"
  }

  set {
    name  = "proxy.stream[0].servicePort"
    value = "1235"
  }

  set {
    name  = "proxy.stream[0].protocol"
    value = "TCP"
  }

  set {
    name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-backend-protocol"
    value = "https"
  }

  set {
    name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-additional-resource-tags"
    value = "Name=${module.generator.prefix}-kong-external"
  }

  set {
    name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-proxy-protocol"
    value = "*"
  }

  set {
    name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-cert"
    value = aws_acm_certificate.external_lb.arn
  }

  set {
    name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-negotiation-policy"
    value = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  }

  set {
    name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-ports"
    value = "443"
  }

  set {
    name  = "proxy.annotations.prometheus\\.io/port"
    value = "10254"
  }

  set {
    name  = "proxy.annotations.prometheus\\.io/scrape"
    value = "true"
  }
}

resource "helm_release" "konghq-internal" {
  name       = "${module.generator.prefix}-kong-internal"
  repository = "https://charts.konghq.com"
  chart      = "kong"
  namespace  = kubernetes_namespace_v1.kong.metadata[0].name
  version    = "2.10.2"

  values = [templatefile("${path.module}/configs/konghq/antiaffinity.yaml", {
    app = "${module.generator.prefix}-kong-internal"
  })]

  set {
    name  = "replicaCount"
    value = 2
  }

  set {
    name  = "ingressController.installCRDs"
    value = "false"
  }

  set {
    name  = "ingressController.ingressClass"
    value = "kong-internal-lb"
  }

  set {
    name  = "proxy.tls.overrideServiceTargetPort"
    value = "8000"
  }

  set {
    name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
    value = "nlb"
  }

  set {
    name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-internal"
    value = "true"
  }

  set {
    name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-backend-protocol"
    value = "https"
  }

  set {
    name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-additional-resource-tags"
    value = "Name=${module.generator.prefix}-kong-internal"
  }

  set {
    name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-proxy-protocol"
    value = "*"
  }

  set {
    name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-cert"
    value = aws_acm_certificate.internal_lb.arn
  }

  set {
    name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-negotiation-policy"
    value = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  }

  set {
    name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-ports"
    value = "443"
  }

  set {
    name  = "proxy.annotations.prometheus\\.io/port"
    value = "10254"
  }

  set {
    name  = "proxy.annotations.prometheus\\.io/scrape"
    value = "true"
  }
}


resource "helm_release" "konghq-chainstack" {
  name       = "${module.generator.prefix}-chainstack"
  repository = "https://charts.konghq.com"
  chart      = "kong"
  namespace  = kubernetes_namespace_v1.kong.metadata[0].name
  version    = "2.13.0"

  values = [templatefile("${path.module}/configs/konghq/values.yaml", {
    app                        = "${module.generator.prefix}-chainstack"
    http_mirror_configmap_name = kubernetes_config_map.kong_plugin-http_mirror.metadata[0].name
  })]

  set {
    name  = "ingressController.image.tag"
    value = "2.8"
  }

  set {
    name  = "replicaCount"
    value = 4
  }

  set {
    name  = "ingressController.ingressClass"
    value = "kong-chainstack-lb"
  }

  set {
    name  = "proxy.tls.overrideServiceTargetPort"
    value = "8000"
  }

  set {
    name  = "ingressController.ingressClassAnnotations.ingressclass\\.kubernetes\\.io/is-default-class"
    value = "true"
  }

  set {
    name  = "ingressController.installCRDs"
    value = "false"
  }

  set {
    name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
    value = "nlb"
  }

  set {
    name  = "proxy.externalTrafficPolicy"
    value = "Local"
  }

  set {
    name  = "proxy.internalTrafficPolicy"
    value = "Local"
  }

  set {
    name  = "proxy.stream[0].containerPort"
    value = "1235"
  }

  set {
    name  = "proxy.stream[0].servicePort"
    value = "1235"
  }

  set {
    name  = "proxy.stream[0].protocol"
    value = "TCP"
  }

  set {
    name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-backend-protocol"
    value = "https"
  }

  set {
    name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-additional-resource-tags"
    value = "Name=${module.generator.prefix}-chainstack"
  }

  set {
    name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-proxy-protocol"
    value = "*"
  }

  set {
    name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-cert"
    value = aws_acm_certificate.external_lb.arn
  }

  set {
    name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-negotiation-policy"
    value = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  }

  set {
    name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-ports"
    value = "443"
  }

  set {
    name  = "proxy.annotations.prometheus\\.io/port"
    value = "10254"
  }

  set {
    name  = "proxy.annotations.prometheus\\.io/scrape"
    value = "true"
  }
}