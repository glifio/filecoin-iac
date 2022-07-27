# https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.4/guide/service/nlb/
# https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.4/guide/service/annotations/ annotations

resource "kubernetes_ingress_v1" "ingress_kong" {
  metadata {
    name      = "kong-${var.get_ingress_backend_service_name}-${var.get_ingress_backend_service_port}-${random_string.rand.result}"
    namespace = var.get_ingress_namespace

    annotations = {
      "kubernetes.io/ingress.class" = "kong-${var.type_lb_scheme}-lb"
      "konghq.com/plugins"          = local.get_kong_list_plugins
      "konghq.com/protocols"        = "https, http"
    }
  }

  spec {
    rule {
      host = var.get_rule_host
      http {
        path {
          path      = var.get_ingress_http_path
          path_type = var.get_ingress_pathType
          backend {
            service {
              name = var.as_is_ingress_backend_service_name ? var.get_ingress_backend_service_name : "${var.get_ingress_backend_service_name}-service"
              port {
                number = var.get_ingress_backend_service_port
              }
            }
          }
        }
      }
    }
  }
}



