# resource "kubernetes_service_account_v1" "snapshots_managment_sa" {
#   metadata {
#     name      = "snapshots-managment-acc"
#     namespace = kubernetes_namespace_v1.network.metadata[0].name
#     labels = {
#       "app.kubernetes.io/managed-by" = "terraform"
#     }
#   }
#   secret {
#     name = kubernetes_secret_v1.snapshots_managment_secret.metadata[0].name
#   }
# }

# resource "kubernetes_secret_v1" "snapshots_managment_secret" {
#   metadata {
#     name      = "snapshots-managment-secret"
#     namespace = kubernetes_namespace_v1.network.metadata[0].name
#   }
# }

# resource "kubernetes_role_v1" "snapshots_managment_role" {
#   metadata {
#     name      = "snapshots-managment"
#     namespace = kubernetes_namespace_v1.network.metadata[0].name
#     labels = {
#       "app.kubernetes.io/managed-by" = "terraform"
#     }
#   }

#   rule {
#     api_groups = ["snapshot.storage.k8s.io"]
#     resources  = ["volumesnapshots"]
#     verbs      = ["list", "get", "delete", "create"]
#   }
# }

# resource "kubernetes_role_binding_v1" "snapshots_managment_role_binding" {
#   metadata {
#     name      = "snapshots-managment-binding"
#     namespace = kubernetes_namespace_v1.network.metadata[0].name
#   }
#   role_ref {
#     api_group = "rbac.authorization.k8s.io"
#     kind      = "Role"
#     name      = kubernetes_role_v1.snapshots_managment_role.metadata[0].name
#     namespace = kubernetes_namespace_v1.network.metadata[0].name
#   }
#   subject {
#     kind      = "ServiceAccount"
#     name      = kubernetes_service_account_v1.snapshots_managment_sa.metadata[0].name
#     namespace = kubernetes_namespace_v1.network.metadata[0].name
#   }
# }

# #TODO: configmap for template
# # 


# #TODO: cron job
# resource "kubernetes_cron_job_v1" "sync_marketdeals" {
#   count = local.is_mainnet_envs
#   metadata {
#     name      = "sync-marketdeals"
#     namespace = kubernetes_namespace_v1.network.metadata[0].name
#   }
#   spec {
#     concurrency_policy            = "Replace"
#     failed_jobs_history_limit     = 1
#     schedule                      = "*/20 * * * *"
#     successful_jobs_history_limit = 1
#     job_template {
#       metadata {}
#       spec {
#         backoff_limit              = 2
#         ttl_seconds_after_finished = 10
#         template {
#           metadata {}
#           spec {
#             service_account_name = kubernetes_service_account_v1.sync_marketdeals[0].metadata[0].name
#             container {
#               name  = "sync-marketdeals"
#               image = "glif/sync-s3-marketdeals:0.0.1"
#               command = ["sh", "-c", templatefile("${path.module}/configs/sync_s3_marketdeals/sync_s3_marketdeals.sh", {
#                 set_s3_bucket_name = aws_s3_bucket.marketdeals_bucket[0].id
#                 set_endpoint_s3    = "http://space00-lotus-service:1234/rpc/v0"
#                 })
#               ]
#             }
#           }
#         }
#       }
#     }
#   }
# }
