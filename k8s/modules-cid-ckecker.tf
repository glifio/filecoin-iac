module "marketdeals_calibration" {
  count                    = local.is_prod_envs
  source                   = "../modules/cid_checker"
  bucket_name              = "marketdeals-calibration"
  get_sa_namespace         = "default"
  get_global_configuration = local.make_global_configuration
}

module "marketdeals_mainnet" {
  count                    = local.is_prod_envs
  source                   = "../modules/cid_checker"
  bucket_name              = "marketdeals"
  get_sa_namespace         = "default"
  get_global_configuration = local.make_global_configuration
}
