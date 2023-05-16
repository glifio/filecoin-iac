resource "helm_release" "cert_manager" {
  name      = local.cert_manager.name
  namespace = local.cert_manager.namespace

  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "1.11.0"

  set {
    name  = "installCRDs"
    value = true
  }
}

resource "kubernetes_manifest" "ssl_cluster_issuer" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"

    metadata = {
      name = "${local.cert_manager.name}-issuer"
    }

    spec = {
      acme = {
        privateKeySecretRef = {
          name = "${local.cert_manager.name}-issuer"
        }
        server = "https://acme-v02.api.letsencrypt.org/directory"
        solvers = [
          {
            http01 = {
              ingress = {
                class = "default"
                podTemplate = {
                  metadata = {
                    annotations = {
                      "kuma.io/sidecar-injection" = false
                      "sidecar.istio.io/inject"   = false
                    }
                  }
                }
              }
            }
          }
        ]
      }
    }
  }
}
