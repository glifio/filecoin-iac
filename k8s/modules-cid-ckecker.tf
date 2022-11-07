module "marketdeals_calibration" {
  count                    = local.is_dev_envs
  source                   = "../modules/cid_checker"
  bucket_name              = "calibration"
  get_sa_namespace         = "default"
  get_global_configuration = local.make_global_configuration
}

module "marketdeals_mainnet" {
  count                    = local.is_mainnet_envs
  source                   = "../modules/cid_checker"
  bucket_name              = "mainnet"
  get_sa_namespace         = "default"
  get_global_configuration = local.make_global_configuration
}

module "marketdeals_wallaby" {
  count                    = local.is_dev_envs
  source                   = "../modules/cid_checker"
  bucket_name              = "wallaby"
  get_sa_namespace         = "default"
  get_global_configuration = local.make_global_configuration
}
