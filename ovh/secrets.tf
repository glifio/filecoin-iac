module "spacenet_secret" {
  source = "../modules/secrets_generator"

  name = "spacenet-public"

  generator_config = local.generator_config
}

module "spacenet_slave_0_secret" {
  source = "../modules/secrets_generator"

  name        = "spacenet-public-slave-0"
  from_secret = module.spacenet_secret.aws_secret_name

  generator_config = local.generator_config
}
