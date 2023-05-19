module "generator" {
  source          = "../generator"
  project         = var.generator_config.project
  region          = var.generator_config.region
  environment     = var.generator_config.environment
  sub_environment = var.generator_config.sub_environment
}
