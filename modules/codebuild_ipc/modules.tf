module "generator" {
  source          = "../../modules/generator"
  project         = lookup(var.generator_inputs, "project", "")
  region          = lookup(var.generator_inputs, "region", "")
  environment     = lookup(var.generator_inputs, "environment", "")
  sub_environment = lookup(var.generator_inputs, "sub_environment", "")
}
