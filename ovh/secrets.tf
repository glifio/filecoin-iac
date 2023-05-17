module "spacenet_secret" {
  source = "../modules/secrets_generator"

  name = "spacenet-public"

  generator_config = local.generator_config
}
