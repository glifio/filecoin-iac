resource "kubernetes_ingress_v1" "post_root" {
  metadata {
    name      = "${local.prefix}-post-root"
    namespace = var.namespace

    annotations = {
      # Due to network load balancer (NLB) decrypting SSL traffic
      # before it comes to ingress controller, the only
      # usable protocol here is http. Using https here
      # will cause 426 status code stating that the traffic
      # has to be upgraded to TLS 1.2 which will never happen
      # unless NLB stops decrypting traffic
      "konghq.com/protocols"     = "http"
      "konghq.com/methods"       = "POST"
      "konghq.com/preserve-host" = "false"


      "konghq.com/plugins" = join(", ", compact([
        kubernetes_manifest.serverless_function-root.manifest.metadata.name,
        kubernetes_manifest.request_transformer-public_access.manifest.metadata.name,
        kubernetes_manifest.response_transformer-content_type.manifest.metadata.name,
        kubernetes_manifest.cors.manifest.metadata.name,
        local.mirror_plugin,
        local.limit_reqs_wo_header_plugin
      ]))
    }
  }

  spec {
    ingress_class_name = local.ingress_class
    rule {
      host = var.domain_name
      http {
        path {
          path      = "/"
          path_type = "Exact"
          backend {
            service {
              name = local.rpc_v1_service
              port {
                number = local.rpc_v1_port
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "post_root_auth" {
  count = var.enable_ext_token_auth ? 1 : 0
  metadata {
    name      = "${local.prefix}-post-root-auth"
    namespace = var.override_auth_ingress_namespace == null ? var.namespace : var.override_auth_ingress_namespace

    annotations = {
      # Due to network load balancer (NLB) decrypting SSL traffic
      # before it comes to ingress controller, the only
      # usable protocol here is http. Using https here
      # will cause 426 status code stating that the traffic
      # has to be upgraded to TLS 1.2 which will never happen
      # unless NLB stops decrypting traffic
      "konghq.com/protocols"             = "http"
      "konghq.com/methods"               = "POST"
      "konghq.com/preserve-host"         = "true"
      "konghq.com/headers.Authorization" = "~*"


      "konghq.com/plugins" = join(", ", compact([
        local.serverless_function_root_plugin,
        local.token_replacement_plugin,
        local.response_transformer_content_type_plugin,
        local.cors_plugin,
        local.mirror_plugin,
        local.ext_token_auth_plugin
      ]))
    }
  }

  spec {
    ingress_class_name = local.ingress_class
    rule {
      host = var.domain_name
      http {
        path {
          path      = "/"
          path_type = "Exact"
          backend {
            service {
              name = var.override_auth_ingress_service == null ? local.rpc_v1_service : var.override_auth_ingress_service
              port {
                number = var.override_auth_ingress_port == null ? local.rpc_v1_port : var.override_auth_ingress_port
              }
            }
          }
        }
      }
    }
  }
}

# That's a mock endpoint required for many services
# to work correctly. Returns 200 upon any request
resource "kubernetes_ingress_v1" "options_root" {
  metadata {
    name      = "${local.prefix}-options-root"
    namespace = var.namespace

    annotations = {
      "konghq.com/protocols" = "http"
      "konghq.com/methods"   = "OPTIONS"

      "konghq.com/plugins" = join(", ", [
        kubernetes_manifest.serverless_function-mock.manifest.metadata.name,
        kubernetes_manifest.cors.manifest.metadata.name
      ])
    }
  }

  spec {
    ingress_class_name = local.ingress_class
    rule {
      host = var.domain_name
      http {
        path {
          path      = "/"
          path_type = "Exact"
          backend {
            service {
              name = local.rpc_v1_service
              port {
                number = local.rpc_v1_port
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "get_root" {
  metadata {
    name      = "${local.prefix}-get-root"
    namespace = var.homepage_namespace

    annotations = {
      "konghq.com/protocols" = "http"
      "konghq.com/methods"   = "GET"

      "konghq.com/plugins" = join(", ", [
        kubernetes_manifest.homepage_cors.manifest.metadata.name
      ])
    }
  }

  spec {
    ingress_class_name = local.ingress_class
    rule {
      host = var.domain_name
      http {
        path {
          path = "/"
          # Must be a prefix to handle static assets
          path_type = "Prefix"
          backend {
            service {
              name = var.homepage_service
              port {
                # If backend service is of type ExternalName,
                # then ports are available only by numeric values
                number = var.homepage_port
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "post_api" {
  metadata {
    name      = "${local.prefix}-post-api"
    namespace = var.homepage_namespace

    annotations = {
      "konghq.com/protocols" = "http"

      "konghq.com/plugins" = join(", ", [
        kubernetes_manifest.homepage_cors.manifest.metadata.name
      ])
    }
  }

  spec {
    ingress_class_name = local.ingress_class
    rule {
      host = var.domain_name
      http {
        path {
          path = "/api"
          # Must be a prefix to handle static assets
          path_type = "Prefix"
          backend {
            service {
              name = var.homepage_service
              port {
                # If backend service is of type ExternalName,
                # then ports are available only by numeric values
                number = var.homepage_port
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "post_subgraph" {
  metadata {
    name      = "${local.prefix}-post-subgraph"
    namespace = var.homepage_namespace

    annotations = {
      "konghq.com/protocols" = "http"

      "konghq.com/plugins" = join(", ", [
        kubernetes_manifest.homepage_cors.manifest.metadata.name
      ])
    }
  }

  spec {
    ingress_class_name = local.ingress_class
    rule {
      host = var.domain_name
      http {
        path {
          path = "/subgraph"
          # Must be a prefix to handle static assets
          path_type = "Prefix"
          backend {
            service {
              name = var.homepage_service
              port {
                # If backend service is of type ExternalName,
                # then ports are available only by numeric values
                number = var.homepage_port
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "get_diluted_supply" {
  metadata {
    name      = "${local.prefix}-get-dilutedsupply"
    namespace = var.namespace

    annotations = {
      "konghq.com/preserve-host" = "false"
      "konghq.com/protocols"     = "http"
      "konghq.com/methods"       = "GET"


      "konghq.com/plugins" = join(", ", [
        kubernetes_manifest.request_transformer-to_diluted_supply.manifest.metadata.name,
        kubernetes_manifest.cors.manifest.metadata.name
      ])
    }
  }

  spec {
    ingress_class_name = local.ingress_class
    rule {
      host = var.domain_name
      http {
        path {
          path      = "/dilutedsupply"
          path_type = "Exact"
          backend {
            service {
              name = kubernetes_service.circulating_supply.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "get_rpc_v0" {
  metadata {
    name      = "${local.prefix}-get-rpc-v0"
    namespace = var.homepage_namespace

    annotations = {
      "konghq.com/protocols" = "http"
      "konghq.com/methods"   = "GET"

      "konghq.com/plugins" = join(", ", [
        kubernetes_manifest.homepage_cors.manifest.metadata.name,
        kubernetes_manifest.request_transformer-to_root.manifest.metadata.name
      ])
    }
  }

  spec {
    ingress_class_name = local.ingress_class
    rule {
      host = var.domain_name
      http {
        path {
          path      = "/rpc/v0"
          path_type = "Exact"
          backend {
            service {
              name = var.homepage_service
              port {
                number = var.homepage_port
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "options_rpc_v0" {
  metadata {
    name      = "${local.prefix}-options-rpc-v0"
    namespace = var.namespace

    annotations = {
      "konghq.com/protocols" = "http"
      "konghq.com/methods"   = "OPTIONS"

      "konghq.com/plugins" = join(", ", [
        kubernetes_manifest.serverless_function-mock.manifest.metadata.name,
        kubernetes_manifest.cors.manifest.metadata.name
      ])
    }
  }

  spec {
    ingress_class_name = local.ingress_class
    rule {
      host = var.domain_name
      http {
        path {
          path      = "/rpc/v0"
          path_type = "Exact"
          backend {
            service {
              name = local.rpc_v0_service
              port {
                number = local.rpc_v0_port
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "post_rpc_v0" {
  metadata {
    name      = "${local.prefix}-post-rpc-v0"
    namespace = var.namespace

    annotations = {
      "konghq.com/protocols"     = "http"
      "konghq.com/methods"       = "POST"
      "konghq.com/preserve-host" = var.preserve_host
      "konghq.com/plugins" = join(", ", compact([
        kubernetes_manifest.request_transformer-public_access.manifest.metadata.name,
        kubernetes_manifest.response_transformer-content_type.manifest.metadata.name,
        kubernetes_manifest.cors.manifest.metadata.name,
        local.mirror_plugin,
        local.limit_reqs_wo_header_plugin
      ]))
    }
  }

  spec {
    ingress_class_name = local.ingress_class
    rule {
      host = var.domain_name
      http {
        path {
          path      = "/rpc/v0"
          path_type = "Exact"
          backend {
            service {
              name = local.rpc_v0_service
              port {
                number = local.rpc_v0_port
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "post_rpc_v0_auth" {
  count = var.enable_ext_token_auth ? 1 : 0
  metadata {
    name      = "${local.prefix}-post-rpc-v0-auth"
    namespace = var.override_auth_ingress_namespace == null ? var.namespace : var.override_auth_ingress_namespace

    annotations = {
      "konghq.com/protocols"             = "http"
      "konghq.com/methods"               = "POST"
      "konghq.com/preserve-host"         = var.preserve_host
      "konghq.com/headers.Authorization" = "~*"

      "konghq.com/plugins" = join(", ", compact([
        local.token_replacement_plugin,
        local.response_transformer_content_type_plugin,
        local.cors_plugin,
        local.mirror_plugin,
        local.ext_token_auth_plugin
      ]))
    }
  }

  spec {
    ingress_class_name = local.ingress_class
    rule {
      host = var.domain_name
      http {
        path {
          path      = "/rpc/v0"
          path_type = "Exact"
          backend {
            service {
              name = var.override_auth_ingress_service == null ? local.rpc_v0_service : var.override_auth_ingress_service
              port {
                number = var.override_auth_ingress_port == null ? local.rpc_v0_port : var.override_auth_ingress_port
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "get_rpc_v1" {
  metadata {
    name      = "${local.prefix}-get-rpc-v1"
    namespace = var.homepage_namespace

    annotations = {
      "konghq.com/protocols" = "http"
      "konghq.com/methods"   = "GET"

      "konghq.com/plugins" = join(", ", [
        kubernetes_manifest.request_transformer-to_root.manifest.metadata.name,
        kubernetes_manifest.homepage_cors.manifest.metadata.name
      ])
    }
  }

  spec {
    ingress_class_name = local.ingress_class
    rule {
      host = var.domain_name
      http {
        path {
          path      = "/rpc/v1"
          path_type = "Exact"
          backend {
            service {
              name = var.homepage_service
              port {
                number = var.homepage_port
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "options_rpc_v1" {
  metadata {
    name      = "${local.prefix}-options-rpc-v1"
    namespace = var.namespace

    annotations = {
      "konghq.com/protocols" = "http"
      "konghq.com/methods"   = "OPTIONS"

      "konghq.com/plugins" = join(", ", [
        kubernetes_manifest.serverless_function-mock.manifest.metadata.name,
        kubernetes_manifest.cors.manifest.metadata.name
      ])
    }
  }

  spec {
    ingress_class_name = local.ingress_class
    rule {
      host = var.domain_name
      http {
        path {
          path      = "/rpc/v1"
          path_type = "Exact"
          backend {
            service {
              name = local.rpc_v1_service
              port {
                number = local.rpc_v1_port
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "post_rpc_v1" {
  metadata {
    name      = "${local.prefix}-post-rpc-v1"
    namespace = var.namespace

    annotations = {
      "konghq.com/protocols"     = "http"
      "konghq.com/methods"       = "POST"
      "konghq.com/preserve-host" = var.preserve_host
      "konghq.com/plugins" = join(", ", compact([
        kubernetes_manifest.request_transformer-public_access.manifest.metadata.name,
        kubernetes_manifest.response_transformer-content_type.manifest.metadata.name,
        kubernetes_manifest.cors.manifest.metadata.name,
        local.mirror_plugin,
        local.limit_reqs_wo_header_plugin
      ]))
    }
  }

  spec {
    ingress_class_name = local.ingress_class
    rule {
      host = var.domain_name
      http {
        path {
          path      = "/rpc/v1"
          path_type = "Exact"
          backend {
            service {
              name = local.rpc_v1_service
              port {
                number = local.rpc_v1_port
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "post_rpc_v1_auth" {
  count = var.enable_ext_token_auth ? 1 : 0
  metadata {
    name      = "${local.prefix}-post-rpc-v1-auth"
    namespace = var.override_auth_ingress_namespace == null ? var.namespace : var.override_auth_ingress_namespace

    annotations = {
      "konghq.com/protocols"             = "http"
      "konghq.com/methods"               = "POST"
      "konghq.com/preserve-host"         = var.preserve_host
      "konghq.com/headers.Authorization" = "~*"

      "konghq.com/plugins" = join(", ", compact([
        local.token_replacement_plugin,
        local.response_transformer_content_type_plugin,
        local.cors_plugin,
        local.mirror_plugin,
        local.ext_token_auth_plugin
      ]))
    }
  }

  spec {
    ingress_class_name = local.ingress_class
    rule {
      host = var.domain_name
      http {
        path {
          path      = "/rpc/v1"
          path_type = "Exact"
          backend {
            service {
              name = var.override_auth_ingress_service == null ? local.rpc_v1_service : var.override_auth_ingress_service
              port {
                number = var.override_auth_ingress_port == null ? local.rpc_v1_port : var.override_auth_ingress_port
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "get_circulating_supply" {
  metadata {
    name      = "${local.prefix}-get-circulating-supply"
    namespace = var.namespace

    annotations = {
      "konghq.com/protocols" = "http"
      "konghq.com/methods"   = "GET"

      "konghq.com/plugins" = join(", ", [
        kubernetes_manifest.request_transformer-daemon_access.manifest.metadata.name,
        kubernetes_manifest.serverless_function-statecirculatingsupply.manifest.metadata.name,
        kubernetes_manifest.cors.manifest.metadata.name
      ])
    }
  }

  spec {
    ingress_class_name = local.ingress_class
    rule {
      host = var.domain_name
      http {
        path {
          path      = "/statecirculatingsupply"
          path_type = "Exact"
          backend {
            service {
              name = local.daemon_service
              port {
                # Method Filecoin.StateCirculatingSupply is not
                # yet supported in Lotus Gateway
                number = var.override_daemon_port
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "get_circulating_supply_fil" {
  metadata {
    name      = "${local.prefix}-get-circulating-supply-fil"
    namespace = var.namespace

    annotations = {
      "konghq.com/preserve-host" = "false"
      "konghq.com/protocols"     = "http"
      "konghq.com/methods"       = "GET"

      "konghq.com/plugins" = join(", ", [
        kubernetes_manifest.request_transformer-to_index.manifest.metadata.name,
        kubernetes_manifest.cors.manifest.metadata.name
      ])
    }
  }

  spec {
    ingress_class_name = local.ingress_class
    rule {
      host = var.domain_name
      http {
        path {
          path      = "/statecirculatingsupply/fil"
          path_type = "Exact"
          backend {
            service {
              name = kubernetes_service.circulating_supply.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "get_circulating_supply_fil_v2" {
  metadata {
    name      = "${local.prefix}-get-circulating-supply-fil-v2"
    namespace = var.namespace

    annotations = {
      "konghq.com/preserve-host" = "false"
      "konghq.com/protocols"     = "http"
      "konghq.com/methods"       = "GET"

      "konghq.com/plugins" = join(", ", [
        kubernetes_manifest.request_transformer-to_index.manifest.metadata.name,
        kubernetes_manifest.cors.manifest.metadata.name
      ])
    }
  }

  spec {
    ingress_class_name = local.ingress_class
    rule {
      host = var.domain_name
      http {
        path {
          path      = "/statecirculatingsupply/fil/v2"
          path_type = "Exact"
          backend {
            service {
              name = kubernetes_service.circulating_supply_staging.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "get_vm_circulating_supply" {
  metadata {
    name      = "${local.prefix}-get-vm-circulating-supply"
    namespace = var.namespace

    annotations = {
      "konghq.com/protocols" = "http"
      "konghq.com/methods"   = "GET"

      "konghq.com/plugins" = join(", ", [
        kubernetes_manifest.serverless_function-vmcirculatingsupply.manifest.metadata.name,
        kubernetes_manifest.request_transformer-daemon_access.manifest.metadata.name,
        kubernetes_manifest.cors.manifest.metadata.name
      ])
    }
  }

  spec {
    ingress_class_name = local.ingress_class
    rule {
      host = var.domain_name
      http {
        path {
          path      = "/vmcirculatingsupply"
          path_type = "Exact"
          backend {
            service {
              name = local.daemon_service
              port {
                number = var.override_daemon_port
              }
            }
          }
        }
      }
    }
  }
}
