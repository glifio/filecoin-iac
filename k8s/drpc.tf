resource "kubernetes_ingress_v1" "drpc" {
  count = local.is_prod_envs

  metadata {
    name      = "drpc-dshackle-ingress"
    namespace = "default"

    annotations = {
      "alb.ingress.kubernetes.io/healthcheck-protocol"     = "HTTP",
      "alb.ingress.kubernetes.io/ssl-redirect"             = "443",
      "alb.ingress.kubernetes.io/backend-protocol-version" = "GRPC",
      "alb.ingress.kubernetes.io/listen-ports"             = "[{\"HTTP\": 80}, {\"HTTPS\":443}]",
      "alb.ingress.kubernetes.io/scheme"                   = "internet-facing",
      "alb.ingress.kubernetes.io/target-type"              = "ip",
      "alb.ingress.kubernetes.io/certificate-arn"          = aws_acm_certificate.external_lb.arn,
      "alb.ingress.kubernetes.io/tags"                     = "Name=${module.generator.prefix}-drpc"
    }
  }

  spec {
    ingress_class_name = "alb"

    rule {
      host = "drpc.${var.route53_domain}"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "glif-drpc-service"
              port {
                number = 2449
              }
            }
          }
        }
      }
    }
  }
}
