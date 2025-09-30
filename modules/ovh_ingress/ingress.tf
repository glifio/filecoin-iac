resource "kubernetes_ingress_v1" "default" {
  count = !var.enable_limit_reqs_wo_header && !var.enable_ext_token_auth ? 1 : 0

  metadata {
    name      = var.name
    namespace = var.namespace

    annotations = {
      "konghq.com/plugins"   = local.plugins_string
      "konghq.com/protocols" = var.protocols
    }
  }

  spec {
    ingress_class_name = var.ingress_class

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

resource "kubernetes_ingress_v1" "default_rate_limiting" {
  count = var.enable_limit_reqs_wo_header ? 1 : 0

  metadata {
    name      = "${var.name}-rate-limit"
    namespace = var.namespace

    annotations = {
      "konghq.com/plugins"   = var.enable_limit_reqs_wo_header ? local.limit_reqs_wo_header_plugins_string : local.plugins_string
      "konghq.com/protocols" = "https, http"
    }
  }

  spec {
    ingress_class_name = var.ingress_class

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

resource "kubernetes_ingress_v1" "default_auth" {
  count = var.enable_ext_token_auth ? 1 : 0

  metadata {
    name      = "${var.name}-auth"
    namespace = var.namespace

    annotations = {
      "konghq.com/plugins"   = local.ext_token_auth_plugins_string
      "konghq.com/protocols" = "https, http"

      "konghq.com/headers.Authorization" = "~*"
    }
  }

  spec {
    ingress_class_name = var.ingress_class

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

resource "kubernetes_ingress_v1" "query_param_auth" {
  count = var.enable_ext_token_auth && var.enable_optional_query_param_auth ? 1 : 0

  metadata {
    name      = "${var.name}-query-param-auth"
    namespace = var.namespace

    annotations = {
      "konghq.com/plugins"   = local.query_param_auth_plugins_string
      "konghq.com/protocols" = "https, http"
    }
  }

  spec {
    ingress_class_name = var.ingress_class

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
