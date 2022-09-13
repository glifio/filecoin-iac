module "generator" {
  source          = "../modules/generator"
  project         = var.project
  region          = var.region
  environment     = var.environment
  sub_environment = var.sub_environment
}

module "codebuild_cd-filecoin-fluent-bit" {
  source                   = "../modules/codebuild"
  git_repository_name      = "filecoin-external-snapshotter"
  get_global_configuration = local.make_codebuild_global_configuration
  depends_on = [
    aws_secretsmanager_secret.github_cd_token_secret
  ]
}

module "codebuild_ci_cid-checker" {
  count                    = local.is_mainnet_envs
  source                   = "../modules/codebuild"
  git_repository_name      = "cid-checker"
  get_global_configuration = local.make_codebuild_global_configuration
  is_build_only            = true
  privileged_mode          = true
  is_build_concurrent      = false

  depends_on = [
    aws_secretsmanager_secret.github_cd_token_secret
  ]
}

module "codebuild_cd_cid-checker" {
  count                    = local.is_mainnet_envs
  source                   = "../modules/codebuild"
  git_repository_name      = "cid-checker"
  get_global_configuration = local.make_codebuild_global_configuration
  privileged_mode          = true
  is_build_concurrent      = false

  depends_on = [
    aws_secretsmanager_secret.github_cd_token_secret
  ]
}
