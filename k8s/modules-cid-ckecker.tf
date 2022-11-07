module "marketdeals_calibration" {
  count           = local.is_dev_envs
  source          = "../modules/cid_checker"
  bucket_name     = "calibration"
  force_destroy   = true
  tags            = module.generator.common_tags
  oidc            = local.oidc_URL
  name_prefix     = module.generator.prefix
}

module "marketdeals_mainnet" {
  count           = local.is_mainnet_envs
  source          = "../modules/cid_checker"
  bucket_name     = "mainnet"
  force_destroy   = true
  tags            = module.generator.common_tags
  oidc            = local.oidc_URL
  name_prefix     = module.generator.prefix
}

module "marketdeals_wallaby" {
  count           = local.is_dev_envs
  source          = "../modules/cid_checker"
  bucket_name     = "wallaby"
  force_destroy   = true
  tags            = module.generator.common_tags
  oidc            = local.oidc_URL
  name_prefix     = module.generator.prefix
}
