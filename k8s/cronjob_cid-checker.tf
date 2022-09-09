resource "kubernetes_cron_job_v1" "cid_checker" {
  count = local.is_mainnet_envs
  metadata {
    name      = "cid-checker"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  spec {
    concurrency_policy            = "Replace"
    failed_jobs_history_limit     = 1
    schedule                      = "*/20 * * * *"
    successful_jobs_history_limit = 1
    job_template {
      metadata {}
      spec {
        backoff_limit              = 2
        ttl_seconds_after_finished = 10
        template {
          metadata {}
          spec {
            container {
              name  = "cid-checker"
              image = "witnsby/cid-checker:0.5" // TODO: we have to change from a personal repo to glif dockerhub repo
              env {
                name = "mongoURL"
                value_from {
                  secret_key_ref {
                    name     = "cid-checker-secret"
                    key      = "mongoURL"
                    optional = false
                  }
                }
              }
              env {
                name  = "fcnode"
                value = "https://node.glif.io/space06/lotus/rpc/v0"
              }
              env {
                name  = "dbName"
                value = "filecoindbspace06"
              }
            }
          }
        }
      }
    }
  }
}
