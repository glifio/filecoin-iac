resource "kubernetes_ingress_v1" "post_root" {
  metadata {
    name      = "${local.prefix}-post-root"
    namespace = var.namespace

    annotations = {
      "kubernetes.io/ingress.class" = var.ingress_class
      "konghq.com/protocols"        = "https, http"
      "konghq.com/methods"          = "POST"

      "konghq.com/plugins" = join(", ", compact([
        kubernetes_manifest.request_transformer-to_rpc_v0.manifest.metadata.name,
        kubernetes_manifest.request_transformer-public_access.manifest.metadata.name
      ]))
    }
  }

  spec {
    rule {
      host = var.domain_name
      http {
        path {
          path      = "/"
          path_type = "Exact"
          backend {
            service {
              name = local.upstream_service
              port {
                number = var.upstream_port
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
    namespace = var.namespace

    annotations = {
      "kubernetes.io/ingress.class" = var.ingress_class
      "konghq.com/protocols"        = "https, http"
      "konghq.com/methods"          = "GET"
    }
  }

  spec {
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
                number = 443
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
      "kubernetes.io/ingress.class" = var.ingress_class
      "konghq.com/protocols"        = "https"
      "konghq.com/methods"          = "GET"

      "konghq.com/plugins" = join(", ", compact([
        kubernetes_manifest.request_transformer-to_diluted_supply.manifest.metadata.name
      ]))
    }
  }

  spec {
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
                number = 443
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
    namespace = var.namespace

    annotations = {
      "kubernetes.io/ingress.class" = var.ingress_class
      "konghq.com/protocols"        = "https"
      "konghq.com/methods"          = "GET"

      "konghq.com/plugins" = join(", ", compact([
        kubernetes_manifest.request_transformer-to_root.manifest.metadata.name
      ]))
    }
  }

  spec {
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
                number = 443
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
      "kubernetes.io/ingress.class" = var.ingress_class
      "konghq.com/protocols"        = "https"
      "konghq.com/methods"          = "POST"

      "konghq.com/plugins" = join(", ", compact([
        kubernetes_manifest.request_transformer-public_access.manifest.metadata.name
      ]))
    }
  }

  spec {
    rule {
      host = var.domain_name
      http {
        path {
          path      = "/rpc/v0"
          path_type = "Exact"
          backend {
            service {
              name = local.upstream_service
              port {
                number = var.upstream_port
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
    namespace = var.namespace

    annotations = {
      "kubernetes.io/ingress.class" = var.ingress_class
      "konghq.com/protocols"        = "https"
      "konghq.com/methods"          = "GET"

      "konghq.com/plugins" = join(", ", compact([
        kubernetes_manifest.request_transformer-to_root.manifest.metadata.name
      ]))
    }
  }

  spec {
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
                number = 443
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
      "kubernetes.io/ingress.class" = var.ingress_class
      "konghq.com/protocols"        = "https"
      "konghq.com/methods"          = "POST"

      "konghq.com/plugins" = join(", ", compact([
        kubernetes_manifest.request_transformer-public_access.manifest.metadata.name
      ]))
    }
  }

  spec {
    rule {
      host = var.domain_name
      http {
        path {
          path      = "/rpc/v1"
          path_type = "Exact"
          backend {
            service {
              name = local.upstream_service
              port {
                number = var.upstream_port
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
      "kubernetes.io/ingress.class" = var.ingress_class
      "konghq.com/protocols"        = "https"
      "konghq.com/methods"          = "GET"

      "konghq.com/plugins" = join(", ", compact([
        kubernetes_manifest.request_transformer-to_rpc_v0.manifest.metadata.name,
        kubernetes_manifest.request_transformer-statecirculatingsupply.manifest.metadata.name,
        kubernetes_manifest.request_transformer-public_access.manifest.metadata.name
      ]))
    }
  }

  spec {
    rule {
      host = var.domain_name
      http {
        path {
          path      = "/statecirculatingsupply"
          path_type = "Exact"
          backend {
            service {
              name = local.upstream_service
              port {
                number = var.upstream_port
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
      "kubernetes.io/ingress.class" = var.ingress_class
      "konghq.com/protocols"        = "https"
      "konghq.com/methods"          = "GET"

      "konghq.com/plugins" = join(", ", compact([
        kubernetes_manifest.request_transformer-to_index.manifest.metadata.name
      ]))
    }
  }

  spec {
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
                number = 443
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
      "kubernetes.io/ingress.class" = var.ingress_class
      "konghq.com/protocols"        = "https"
      "konghq.com/methods"          = "GET"

      "konghq.com/plugins" = join(", ", compact([
        kubernetes_manifest.request_transformer-to_index.manifest.metadata.name
      ]))
    }
  }

  spec {
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
                number = 443
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
      "kubernetes.io/ingress.class" = var.ingress_class
      "konghq.com/protocols"        = "https"
      "konghq.com/methods"          = "GET"

      "konghq.com/plugins" = join(", ", compact([
        kubernetes_manifest.request_transformer-to_rpc_v0.manifest.metadata.name,
        kubernetes_manifest.request_transformer-vmcirculatingsupply.manifest.metadata.name,
        kubernetes_manifest.request_transformer-public_access.manifest.metadata.name
      ]))
    }
  }

  spec {
    rule {
      host = var.domain_name
      http {
        path {
          path      = "/vmcirculatingsupply"
          path_type = "Exact"
          backend {
            service {
              name = local.upstream_service
              port {
                number = var.upstream_port
              }
            }
          }
        }
      }
    }
  }
}
