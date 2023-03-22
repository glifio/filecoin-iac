resource "kubernetes_manifest" "kong_sticky_sessions" {
  count = local.is_prod_envs
  manifest = {
    apiVersion = "configuration.konghq.com/v1"
    kind       = "KongIngress"
    metadata = {
      name = "${terraform.workspace}-kong-sticky-sessions"
      namespace = kubernetes_namespace_v1.network.metadata[0].name
    }

    upstream = {
      hash_on = "ip"
      hash_fallback = "none"
      algorithm = "consistent-hashing"
    }

    proxy = {
      protocol     = "http"
      read_timeout = 600000
    }
  }
}