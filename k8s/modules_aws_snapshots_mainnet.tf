module "space00_snapshot" {
  count              = local.is_mainnet_envs
  source             = "../modules/cronjob_aws_snapshots_managment"
  sts_name           = "space00"
  volume_name_prefix = "vol-lotus-io2"
  namespace          = kubernetes_namespace_v1.network.metadata[0].name
  creator_cron       = "0 0 * * *"
  deleter_cron       = "0 2 * * *"
  snaps_to_keep      = 7
}
