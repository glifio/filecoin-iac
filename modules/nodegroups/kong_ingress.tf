## https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.4/guide/service/nlb/
## https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.4/guide/service/annotations/ annotations

resource "kubernetes_ingress_v1" "ingress_kong" {
  count = var.create_ingress_kong ? 1 : 0
  metadata {
    name      = "kong-${var.get_nodegroup_name}-lotus-service-${var.service_port}"
    namespace = var.get_namespace

    annotations = {
      "konghq.com/plugins"   = local.plugins_string
      "konghq.com/protocols" = "https, http"
    }
  }
  spec {
    ingress_class_name = "kong-${var.type_lb_scheme}-lb"
    rule {
      host = var.http_host
      http {
        path {
          path      = var.http_path
          path_type = var.http_path_type
          backend {
            service {
              name = "${var.get_nodegroup_name}-lotus-service"
              port {
                number = var.service_port
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "ingress_kong_ipfs" {
  count = var.create_ingress_kong_ipfs ? 1 : 0
  metadata {
    name      = "kong-${var.get_nodegroup_name}-ipfs-${var.service_port_ipfs}"
    namespace = var.get_namespace

    annotations = {
      "konghq.com/plugins"   = local.plugins_string
      "konghq.com/protocols" = "https, http"
    }
  }

  spec {
    ingress_class_name = "kong-${var.type_lb_scheme}-lb"
    rule {
      host = var.http_host
      http {
        path {
          path      = var.http_path_ipfs
          path_type = var.http_path_type
          backend {
            service {
              name = "${var.get_nodegroup_name}-ipfs"
              port {
                number = var.service_port_ipfs
              }
            }
          }
        }
      }
    }
  }
}


