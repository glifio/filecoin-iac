module "generator_global" {
  source          = "../modules/generator"
  project         = var.project
  region          = var.region
  environment     = "global"
  sub_environment = var.sub_environment
}

module "generator_dev" {
  source          = "../modules/generator"
  project         = var.project
  region          = var.region
  environment     = "dev"
  sub_environment = var.sub_environment
}

module "generator_mainnet" {
  source          = "../modules/generator"
  project         = var.project
  region          = var.region
  environment     = "mainnet"
  sub_environment = var.sub_environment
}
