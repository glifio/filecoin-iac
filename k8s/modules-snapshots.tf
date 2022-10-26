### Start block: Snapshot for dev ###

module "calibrationapi_chain_snapshot" {
  count     = local.is_dev_envs
  source    = "../modules/cronjob_lotus_chain_snapshots"
  sts_name  = "calibrationapi"
  namespace = kubernetes_namespace_v1.network.metadata[0].name
  git_repo  = "git@gist.github.com:95da15b014ffc3b5a170485001f46abd.git"
  schedule  = "0 0 * * *"
}

module "calibrationapi_archive_node_snapshot" {
  count         = local.is_dev_envs
  source        = "../modules/cronjob_aws_snapshots_managment"
  sts_name      = "calibrationapi-archive-node"
  namespace     = kubernetes_namespace_v1.network.metadata[0].name
  creator_cron  = "0 0 * * SAT"
  deleter_cron  = "0 2 * * SAT"
  snaps_to_keep = 2
}

### End block: Snapshot for dev ###


### Start block: Snapshot for mainnet ###

## A module space00_snapshot should create aws snapshots
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

module "mainnet_chain_snapshot" {
  count     = local.is_mainnet_envs
  source    = "../modules/cronjob_lotus_chain_snapshots"
  sts_name  = "space00"
  namespace = kubernetes_namespace_v1.network.metadata[0].name
  git_repo  = "git@gist.github.com:d03393d1f6e70e089e9e8d18922474f6.git"
  schedule  = "0 12 * * *"
}

### End block: Snapshot for mainnet ###
