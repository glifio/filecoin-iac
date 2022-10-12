module "calibrationapi_chain_snapshot" {
  count     = local.is_dev_envs
  source    = "../modules/cronjob_lotus_chain_snapshots"
  sts_name  = "calibrationapi"
  namespace = kubernetes_namespace_v1.network.metadata[0].name
  git_repo  = "git@gist.github.com:95da15b014ffc3b5a170485001f46abd.git"
  schedule  = "0 0 * * *"
}
