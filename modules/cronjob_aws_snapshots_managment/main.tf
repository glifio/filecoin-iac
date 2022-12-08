resource "kubernetes_service_account_v1" "this" {
  metadata {
    name      = "${var.sts_name}-snap-acc"
    namespace = var.namespace
  }
}

resource "kubernetes_role_v1" "this" {
  metadata {
    name      = "${var.sts_name}-snap"
    namespace = var.namespace
  }

  rule {
    api_groups = ["snapshot.storage.k8s.io"]
    resources  = ["volumesnapshots"]
    verbs      = ["list", "watch", "get", "delete", "create"]
  }
}

resource "kubernetes_role_binding_v1" "this" {
  metadata {
    name      = "${var.sts_name}-snap-binding"
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

resource "kubernetes_config_map_v1" "this" {
  metadata {
    name      = "${var.sts_name}-snap-cm"
    namespace = var.namespace
  }
  data = {
    "snapshot-template.yaml" = templatefile("${path.module}/templates/snapshot_template/snapshot-template.yaml", {
      sts_name      = var.sts_name
      full_pvc_name = local.full_pvc_name
      namespace     = var.namespace
    })
  }
}

resource "kubernetes_cron_job_v1" "snap_creator" {
  metadata {
    name      = "${var.sts_name}-snap-creator"
    namespace = var.namespace
  }
  spec {
    concurrency_policy            = "Forbid"
    failed_jobs_history_limit     = 1
    schedule                      = var.creator_cron
    successful_jobs_history_limit = 1
    job_template {
      metadata {}
      spec {
        template {
          metadata {}
          spec {
            service_account_name = kubernetes_service_account_v1.this.metadata[0].name
            restart_policy       = "Never"
            node_selector = {
              "kubernetes.io/arch" = "amd64"
              "assign_to_space00_07_nodes" = "allow_any_pods"
            }
            container {
              name  = "${var.sts_name}-snap-creator"
              image = "bitnami/kubectl"
              args  = ["create", "-f", "/tmp/creator/snapshot-template.yaml"]
              volume_mount {
                name       = "${var.sts_name}-snap-cm"
                mount_path = "/tmp/creator"
                read_only  = true
              }
            }
            volume {
              name = "${var.sts_name}-snap-cm"
              config_map {
                name = kubernetes_config_map_v1.this.metadata[0].name
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_cron_job_v1" "snap_deleter" {
  metadata {
    name      = "${var.sts_name}-snap-deleter"
    namespace = var.namespace
  }
  spec {
    concurrency_policy            = "Forbid"
    failed_jobs_history_limit     = 1
    schedule                      = var.deleter_cron
    successful_jobs_history_limit = 1
    job_template {
      metadata {}
      spec {
        template {
          metadata {}
          spec {
            service_account_name = kubernetes_service_account_v1.this.metadata[0].name
            restart_policy       = "Never"
            container {
              name  = "${var.sts_name}-snap-deleter"
              image = "bitnami/kubectl"
              command = ["bash", "-c", templatefile("${path.module}/configs/deleter/deleter.sh", {
                namespace     = var.namespace,
                sts_name      = var.sts_name,
                snaps_to_keep = var.snaps_to_keep
                })
              ]
            }
          }
        }
      }
    }
  }
}

