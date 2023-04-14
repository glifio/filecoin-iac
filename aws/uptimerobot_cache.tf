module "uptimerobot_cache" {
  count = local.is_prod_envs

  source = "../modules/uptimerobot_cache"
  providers = {
    aws = aws.virginia
  }

  global_config = local.make_global_configuration
  bucket_name = "uptimerobot-cache-prod"
}

