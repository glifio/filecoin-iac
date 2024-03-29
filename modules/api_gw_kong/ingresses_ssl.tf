resource "kubernetes_ingress_v1" "ssl-post_root" {
  count = local.ssl_ingress_count
  metadata {
    name      = "${local.prefix}-post-root"
    namespace = var.namespace

    annotations = {
      "cert-manager.io/cluster-issuer" = var.certificate_issuer

      # Due to network load balancer (NLB) decrypting SSL traffic
      # before it comes to ingress controller, the only
      # usable protocol here is http. Using https here
      # will cause 426 status code stating that the traffic
      # has to be upgraded to TLS 1.2 which will never happen
      # unless NLB stops decrypting traffic
      "konghq.com/protocols"     = "http, https"
      "konghq.com/methods"       = "POST"
      "konghq.com/preserve-host" = "false"


      "konghq.com/plugins" = join(", ", compact([
        kubernetes_manifest.serverless_function-root.manifest.metadata.name,
        kubernetes_manifest.request_transformer-public_access.manifest.metadata.name,
        kubernetes_manifest.response_transformer-content_type.manifest.metadata.name,
        kubernetes_manifest.cors.manifest.metadata.name,
        local.mirror_plugin
      ]))
    }
  }

  spec {
    ingress_class_name = local.ingress_class

    tls {
      hosts       = [var.domain_name]
      secret_name = "${var.domain_name}-ssl"
    }

    rule {
      host = var.domain_name
      http {
        path {
          path      = "/"
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

# That's a mock endpoint required for many services
# to work correctly. Returns 200 upon any request
resource "kubernetes_ingress_v1" "ssl-options_root" {
  count = local.ssl_ingress_count
  metadata {
    name      = "${local.prefix}-options-root"
    namespace = var.namespace

    annotations = {
      "cert-manager.io/cluster-issuer" = var.certificate_issuer

      "konghq.com/protocols" = "http, https"
      "konghq.com/methods"   = "OPTIONS"

      "konghq.com/plugins" = join(", ", [
        kubernetes_manifest.serverless_function-mock.manifest.metadata.name,
        kubernetes_manifest.cors.manifest.metadata.name
      ])
    }
  }

  spec {
    ingress_class_name = local.ingress_class

    tls {
      hosts       = [var.domain_name]
      secret_name = "${var.domain_name}-ssl"
    }

    rule {
      host = var.domain_name
      http {
        path {
          path      = "/"
          path_type = "Exact"
          backend {
            service {
              name = kubernetes_service.homepage.metadata[0].name
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

resource "kubernetes_ingress_v1" "ssl-get_root" {
  count = local.ssl_ingress_count
  metadata {
    name      = "${local.prefix}-get-root"
    namespace = var.namespace

    annotations = {
      "cert-manager.io/cluster-issuer" = var.certificate_issuer

      # If this annotation is not present, the request
      # will be looping over the host name infinitely
      "konghq.com/preserve-host" = "false"
      "konghq.com/protocols"     = "http, https"
      "konghq.com/methods"       = "GET"

      "konghq.com/plugins" = join(", ", [
        kubernetes_manifest.cors.manifest.metadata.name
      ])
    }
  }

  spec {
    ingress_class_name = local.ingress_class

    tls {
      hosts       = [var.domain_name]
      secret_name = "${var.domain_name}-ssl"
    }

    rule {
      host = var.domain_name
      http {
        path {
          path = "/"
          # Must be a prefix to handle static assets
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service.homepage.metadata[0].name
              port {
                # If backend service is of type ExternalName,
                # then ports are available only by numeric values
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "ssl-get_diluted_supply" {
  count = local.ssl_ingress_count
  metadata {
    name      = "${local.prefix}-get-dilutedsupply"
    namespace = var.namespace

    annotations = {
      "cert-manager.io/cluster-issuer" = var.certificate_issuer

      "konghq.com/preserve-host" = "false"
      "konghq.com/protocols"     = "http, https"
      "konghq.com/methods"       = "GET"


      "konghq.com/plugins" = join(", ", [
        kubernetes_manifest.request_transformer-to_diluted_supply.manifest.metadata.name,
        kubernetes_manifest.cors.manifest.metadata.name
      ])
    }
  }

  spec {
    ingress_class_name = local.ingress_class

    tls {
      hosts       = [var.domain_name]
      secret_name = "${var.domain_name}-ssl"
    }

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

resource "kubernetes_ingress_v1" "ssl-get_rpc_v0" {
  count = local.ssl_ingress_count
  metadata {
    name      = "${local.prefix}-get-rpc-v0"
    namespace = var.namespace

    annotations = {
      "cert-manager.io/cluster-issuer" = var.certificate_issuer

      "konghq.com/protocols"     = "http, https"
      "konghq.com/methods"       = "GET"
      "konghq.com/preserve-host" = "false"
      "konghq.com/strip-path"    = "true"

      "konghq.com/plugins" = join(", ", [
        kubernetes_manifest.request_transformer-to_root.manifest.metadata.name,
        kubernetes_manifest.cors.manifest.metadata.name
      ])
    }
  }

  spec {
    ingress_class_name = local.ingress_class

    tls {
      hosts       = [var.domain_name]
      secret_name = "${var.domain_name}-ssl"
    }

    rule {
      host = var.domain_name
      http {
        path {
          path      = "/rpc/v0"
          path_type = "Exact"
          backend {
            service {
              name = kubernetes_service.homepage.metadata[0].name
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

resource "kubernetes_ingress_v1" "ssl-options_rpc_v0" {
  count = local.ssl_ingress_count
  metadata {
    name      = "${local.prefix}-options-rpc-v0"
    namespace = var.namespace

    annotations = {
      "cert-manager.io/cluster-issuer" = var.certificate_issuer

      "konghq.com/protocols" = "http, https"
      "konghq.com/methods"   = "OPTIONS"

      "konghq.com/plugins" = join(", ", [
        kubernetes_manifest.serverless_function-mock.manifest.metadata.name,
        kubernetes_manifest.cors.manifest.metadata.name
      ])
    }
  }

  spec {
    ingress_class_name = local.ingress_class

    tls {
      hosts       = [var.domain_name]
      secret_name = "${var.domain_name}-ssl"
    }

    rule {
      host = var.domain_name
      http {
        path {
          path      = "/rpc/v0"
          path_type = "Exact"
          backend {
            service {
              name = kubernetes_service.homepage.metadata[0].name
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

resource "kubernetes_ingress_v1" "ssl-post_rpc_v0" {
  count = local.ssl_ingress_count
  metadata {
    name      = "${local.prefix}-post-rpc-v0"
    namespace = var.namespace

    annotations = {
      "cert-manager.io/cluster-issuer" = var.certificate_issuer

      "konghq.com/protocols" = "http, https"
      "konghq.com/methods"   = "POST"
      "konghq.com/preserve-host" = var.preserve_host
      "konghq.com/plugins" = join(", ", compact([
        kubernetes_manifest.request_transformer-public_access.manifest.metadata.name,
        kubernetes_manifest.response_transformer-content_type.manifest.metadata.name,
        kubernetes_manifest.cors.manifest.metadata.name,
        local.mirror_plugin
      ]))
    }
  }

  spec {
    ingress_class_name = local.ingress_class

    tls {
      hosts       = [var.domain_name]
      secret_name = "${var.domain_name}-ssl"
    }

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

resource "kubernetes_ingress_v1" "ssl-get_rpc_v1" {
  count = local.ssl_ingress_count
  metadata {
    name      = "${local.prefix}-get-rpc-v1"
    namespace = var.namespace

    annotations = {
      "cert-manager.io/cluster-issuer" = var.certificate_issuer

      "konghq.com/protocols"     = "http, https"
      "konghq.com/methods"       = "GET"
      "konghq.com/preserve-host" = "false"
      "konghq.com/strip-path"    = "true"

      "konghq.com/plugins" = join(", ", [
        kubernetes_manifest.request_transformer-to_root.manifest.metadata.name,
        kubernetes_manifest.cors.manifest.metadata.name
      ])
    }
  }

  spec {
    ingress_class_name = local.ingress_class

    tls {
      hosts       = [var.domain_name]
      secret_name = "${var.domain_name}-ssl"
    }

    rule {
      host = var.domain_name
      http {
        path {
          path      = "/rpc/v1"
          path_type = "Exact"
          backend {
            service {
              name = kubernetes_service.homepage.metadata[0].name
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

resource "kubernetes_ingress_v1" "ssl-options_rpc_v1" {
  count = local.ssl_ingress_count
  metadata {
    name      = "${local.prefix}-options-rpc-v1"
    namespace = var.namespace

    annotations = {
      "cert-manager.io/cluster-issuer" = var.certificate_issuer

      "konghq.com/protocols" = "http, https"
      "konghq.com/methods"   = "OPTIONS"

      "konghq.com/plugins" = join(", ", [
        kubernetes_manifest.serverless_function-mock.manifest.metadata.name,
        kubernetes_manifest.cors.manifest.metadata.name
      ])
    }
  }

  spec {
    ingress_class_name = local.ingress_class

    tls {
      hosts       = [var.domain_name]
      secret_name = "${var.domain_name}-ssl"
    }

    rule {
      host = var.domain_name
      http {
        path {
          path      = "/rpc/v1"
          path_type = "Exact"
          backend {
            service {
              name = kubernetes_service.homepage.metadata[0].name
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

resource "kubernetes_ingress_v1" "ssl-post_rpc_v1" {
  count = local.ssl_ingress_count
  metadata {
    name      = "${local.prefix}-post-rpc-v1"
    namespace = var.namespace

    annotations = {
      "cert-manager.io/cluster-issuer" = var.certificate_issuer

      "konghq.com/protocols" = "http, https"
      "konghq.com/methods"   = "POST"
      "konghq.com/preserve-host" = var.preserve_host
      "konghq.com/plugins" = join(", ", compact([
        kubernetes_manifest.request_transformer-public_access.manifest.metadata.name,
        kubernetes_manifest.response_transformer-content_type.manifest.metadata.name,
        kubernetes_manifest.cors.manifest.metadata.name,
        local.mirror_plugin
      ]))
    }
  }

  spec {
    ingress_class_name = local.ingress_class

    tls {
      hosts       = [var.domain_name]
      secret_name = "${var.domain_name}-ssl"
    }

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

resource "kubernetes_ingress_v1" "ssl-get_circulating_supply" {
  count = local.ssl_ingress_count
  metadata {
    name      = "${local.prefix}-get-circulating-supply"
    namespace = var.namespace

    annotations = {
      "cert-manager.io/cluster-issuer" = var.certificate_issuer

      "konghq.com/protocols" = "http, https"
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

    tls {
      hosts       = [var.domain_name]
      secret_name = "${var.domain_name}-ssl"
    }

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

resource "kubernetes_ingress_v1" "ssl-get_circulating_supply_fil" {
  count = local.ssl_ingress_count
  metadata {
    name      = "${local.prefix}-get-circulating-supply-fil"
    namespace = var.namespace

    annotations = {
      "cert-manager.io/cluster-issuer" = var.certificate_issuer

      "konghq.com/preserve-host" = "false"
      "konghq.com/protocols"     = "http, https"
      "konghq.com/methods"       = "GET"

      "konghq.com/plugins" = join(", ", [
        kubernetes_manifest.request_transformer-to_index.manifest.metadata.name,
        kubernetes_manifest.cors.manifest.metadata.name
      ])
    }
  }

  spec {
    ingress_class_name = local.ingress_class

    tls {
      hosts       = [var.domain_name]
      secret_name = "${var.domain_name}-ssl"
    }

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

resource "kubernetes_ingress_v1" "ssl-get_circulating_supply_fil_v2" {
  count = local.ssl_ingress_count
  metadata {
    name      = "${local.prefix}-get-circulating-supply-fil-v2"
    namespace = var.namespace

    annotations = {
      "cert-manager.io/cluster-issuer" = var.certificate_issuer

      "konghq.com/preserve-host" = "false"
      "konghq.com/protocols"     = "http, https"
      "konghq.com/methods"       = "GET"

      "konghq.com/plugins" = join(", ", [
        kubernetes_manifest.request_transformer-to_index.manifest.metadata.name,
        kubernetes_manifest.cors.manifest.metadata.name
      ])
    }
  }

  spec {
    ingress_class_name = local.ingress_class

    tls {
      hosts       = [var.domain_name]
      secret_name = "${var.domain_name}-ssl"
    }

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

resource "kubernetes_ingress_v1" "ssl-get_vm_circulating_supply" {
  count = local.ssl_ingress_count
  metadata {
    name      = "${local.prefix}-get-vm-circulating-supply"
    namespace = var.namespace

    annotations = {
      "cert-manager.io/cluster-issuer" = var.certificate_issuer

      "konghq.com/protocols" = "http, https"
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

    tls {
      hosts       = [var.domain_name]
      secret_name = "${var.domain_name}-ssl"
    }

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
