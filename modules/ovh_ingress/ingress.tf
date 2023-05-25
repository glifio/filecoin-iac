resource "kubernetes_ingress_v1" "default_ssl" {
  count = var.enable_letsencrypt ? 1 : 0

  metadata {
    name      = var.name
    namespace = var.namespace

    annotations = {
      "konghq.com/plugins"             = local.plugins_string
      "konghq.com/protocols"           = "https, http"
      "cert-manager.io/cluster-issuer" = var.certificate_issuer
    }
  }

  spec {
    ingress_class_name = var.incress_class

    tls {
      hosts       = [var.http_host]
      secret_name = "${var.name}-ssl"
    }

    rule {
      host = var.http_host
      http {
        path {
          path      = var.http_path
          path_type = var.http_path_type
          backend {
            service {
              name = var.service_name
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

resource "kubernetes_ingress_v1" "default" {
  count = !var.enable_letsencrypt ? 1 : 0

  metadata {
    name      = var.name
    namespace = var.namespace

    annotations = {
      "konghq.com/plugins"   = local.plugins_string
      "konghq.com/protocols" = "https, http"
    }
  }

  spec {
    ingress_class_name = var.incress_class

    rule {
      host = var.http_host
      http {
        path {
          path      = var.http_path
          path_type = var.http_path_type
          backend {
            service {
              name = var.service_name
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
