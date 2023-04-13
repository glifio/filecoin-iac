module "uptimerobot_cache" {
  source = "../modules/uptimerobot_cache"
  global_config = local.make_global_configuration
  bucket_name = "glif-uptimerobot-cache-dev"
}
