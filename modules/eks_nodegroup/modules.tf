module "generator" {
  source          = "../../modules/generator"
  project         = local.project
  region          = local.region
  environment     = local.env
  sub_environment = local.subenv
}
