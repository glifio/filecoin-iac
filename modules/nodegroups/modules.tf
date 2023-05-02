module "generator" {
  source          = "../../modules/generator"
  project         = local.get_project
  region          = local.get_region
  environment     = local.get_environment
  sub_environment = local.get_sub_environment
}