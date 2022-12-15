resource "kubernetes_service_account_v1" "this" {
  metadata {
    name      = "${var.sts_name}-chain-snap-acc"
    namespace = var.namespace
  }
}

resource "kubernetes_role_v1" "this" {
  metadata {
    name      = "${var.sts_name}-chain-snap"
    namespace = var.namespace
  }

  rule {
    api_groups     = [""]
    resources      = ["pods/exec"]
    resource_names = [local.pod_name]
    verbs          = ["create"]
  }
  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get"]
  }
}

resource "kubernetes_role_binding_v1" "this" {
  metadata {
    name      = "${var.sts_name}-chain-snap-binding"
    namespace = var.namespace
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role_v1.this.metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account_v1.this.metadata[0].name
    namespace = var.namespace
  }
}

resource "kubernetes_cron_job_v1" "this" {
  metadata {
    name      = "${var.sts_name}-chain-snap-creator"
    namespace = var.namespace
  }
  spec {
    concurrency_policy            = "Forbid"
    failed_jobs_history_limit     = 1
    schedule                      = var.schedule
    successful_jobs_history_limit = 1
    suspend = var.is_suspended
    job_template {
      metadata {}
      spec {
        template {
          metadata {}
          spec {
            service_account_name = kubernetes_service_account_v1.this.metadata[0].name
            restart_policy       = "Never"
            init_container {
              name  = "${var.sts_name}-chain-snap-creator"
              image = "bitnami/kubectl"
              command = ["bash", "-c", templatefile("${path.module}/configs/creator/creator.sh", {
                namespace        = var.namespace,
                blocks_to_export = var.blocks_to_export
                pod              = local.pod_name,
                container        = "filecoin",
                cur_snap         = "/data/ipfs/lotus-current.car"
                new_snap         = "/data/ipfs/lotus-new.car"
                shell            = "bash",
                })
              ]
            }
            init_container {
              name  = "${var.sts_name}-chain-snap-sharer"
              image = "bitnami/kubectl"
              command = ["bash", "-c", templatefile("${path.module}/configs/sharer/sharer.sh", {
                namespace        = var.namespace,
                pod              = local.pod_name,
                container        = "filecoin-ipfs",
                cur_snap         = "/data/ipfs/lotus-current.car"
                file_to_store_id = "/data/ipfs/current_snapshot.name",
                shell            = "sh",
                })
              ]
            }
            node_selector = {
              "kubernetes.io/arch" = "amd64"
              "assign_to_space00_07_nodes" = "allow_any_pods"
            }
            container {
              name  = "${var.sts_name}-chain-snap-gitter"
              image = "bitnami/kubectl"
              command = ["bash", "-c", templatefile("${path.module}/configs/gitter/gitter.sh", {
                namespace        = var.namespace,
                pod              = local.pod_name,
                container        = "filecoin",
                file_to_store_id = "/data/ipfs/current_snapshot.name",
                shell            = "bash",
                git_repo         = var.git_repo,
                git_author       = var.git_author
                git_email        = var.git_email
                })
              ]
              #TODO: rewrite logic to remove this codesmell user 0 below
              security_context {
                run_as_user = 0
              }
              volume_mount {
                name       = "chain-snap-ssh-secret"
                mount_path = "/secret"
                read_only  = true
              }
              env {
                name  = "GIT_SSH_COMMAND"
                value = "ssh -i /secret/ssh -o IdentitiesOnly=yes"
              }
            }
            volume {
              name = "chain-snap-ssh-secret"
              secret {
                secret_name  = "github-ssh-gist-updater"
                default_mode = "0600"
              }
            }
          }
        }
      }
    }
  }
}
