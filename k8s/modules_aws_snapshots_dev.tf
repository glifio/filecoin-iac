module "calibrationapi_archive_node_snapshot" {
  count         = local.is_dev_envs
  source        = "../modules/cronjob_aws_snapshots_managment"
  sts_name      = "calibrationapi-archive-node"
  namespace     = kubernetes_namespace_v1.network.metadata[0].name
  creator_cron  = "0 0 * * SAT"
  deleter_cron  = "0 2 * * SAT"
  snaps_to_keep = 2
}
