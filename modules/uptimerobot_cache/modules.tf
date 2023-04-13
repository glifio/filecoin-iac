module "generator" {
  source          = "../../modules/generator"
  project         = var.global_config["project"]
  region          = var.global_config["region"]
  environment     = var.global_config["environment"]
  sub_environment = var.global_config["sub_environment"]
}
