resource "kubernetes_ingress_v1" "filecoin_chain_love" {
  count = local.is_prod_envs

  metadata {
    name      = "filecoin-chain-love"
    namespace = "proteus-shield"
  }

  spec {
    ingress_class_name = "kong-external-lb"

    rule {
      host = "filecoin.chain.love"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "proteus-shield-proxy-svc"
              port {
                number = 8080
              }
            }
          }
        }
      }
    }

    rule {
      host = "calibration.filecoin.chain.love"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "proteus-shield-proxy-svc"
              port {
                number = 8080
              }
            }
          }
        }
      }
    }
  }
}