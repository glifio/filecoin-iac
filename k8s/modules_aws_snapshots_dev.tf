module "test-calibrationapi" {
  count     = local.is_dev_envs
  source    = "../modules/cronjob_aws_snapshots_managment"
  sts_name  = "test-calibrationapi"
  namespace = kubernetes_namespace_v1.network.metadata[0].name
}

# module "calibrationapi_archive_snapshot" {
#   count       = local.is_dev_envs
#   source      = "../modules/cronjob_aws_snapshots_managment"
#   volume_name = "calibrationapi-archive-node"
#   namespace   = kubernetes_namespace_v1.network.metadata[0].name
# }


# module "wallaby_archive_snapshot" {
#   count       = local.is_dev_envs
#   source      = "../modules/cronjob_aws_snapshots_managment"
#   volume_name = "wallaby-archive"
#   namespace   = kubernetes_namespace_v1.network.metadata[0].name
# }


#   snapshot_volume_name = {
#     filecoin-dev-apn1-glif-eks = [
#       "calibrationapi-archive-node",
#       "wallaby-archive"
#     ]
#     filecoin-mainnet-apn1-glif-eks = [
#       "io2-space00",
#       "io2-space07"
#     ]
#   }
#   snapshot_volume_names = local.snapshot_volume_name[terraform.workspace]
