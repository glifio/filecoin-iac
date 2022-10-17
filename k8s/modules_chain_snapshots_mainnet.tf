module "calibrationapi_chain_snapshot" {
  count     = local.is_mainnet_envs
  source    = "../modules/cronjob_lotus_chain_snapshots"
  sts_name  = "space00"
  namespace = kubernetes_namespace_v1.network.metadata[0].name
  git_repo  = "git@gist.github.com:d03393d1f6e70e089e9e8d18922474f6.git"
  schedule  = "0 12 * * *"
}
