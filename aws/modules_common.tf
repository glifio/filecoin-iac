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
  enable_notifications     = false
  depends_on = [
    aws_secretsmanager_secret.github_cd_token_secret
  ]
}

module "codebuild_multirepository_cd_mainnet_amd64" {
  count                    = local.is_prod_envs
  source                   = "../modules/codebuild_multirepositories"
  git_repository_name      = "lotus"
  buildspec_logic          = file("${path.module}/templates/codebuild/deploy_mainnet_amd64.yaml")
  get_global_configuration = local.make_codebuild_global_configuration
  privileged_mode          = true
  is_build_concurrent      = false
  github_cd_token_secret   = "github_cd_rersonal_token_secret"
  specific_branch          = "v1.20.3"
  create_build_webhook     = false
  create_deploy_webhook    = false
  environment_compute_type = "BUILD_GENERAL1_LARGE"
  environment_type         = "LINUX_CONTAINER"
  codebuild_image          = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
  project_name             = "api-read-amd64"

  depends_on = [
    aws_secretsmanager_secret.github_cd_token_secret
  ]
}

module "codebuild_multirepository_cd_mainnet_arm64" {
  count                    = local.is_prod_envs
  source                   = "../modules/codebuild_multirepositories"
  git_repository_name      = "lotus"
  buildspec_logic          = file("${path.module}/templates/codebuild/deploy_mainnet_arm64.yaml")
  get_global_configuration = local.make_codebuild_global_configuration
  privileged_mode          = true
  is_build_concurrent      = false
  github_cd_token_secret   = "github_cd_rersonal_token_secret"
  specific_branch          = "v1.21.0-rpc-p01-methods"
  create_build_webhook     = false
  create_deploy_webhook    = false
  environment_compute_type = "BUILD_GENERAL1_LARGE"
  project_name             = "api-read-arm64"

  depends_on = [
    aws_secretsmanager_secret.github_cd_token_secret
  ]
}

module "codebuild_forest" {
  source                   = "../modules/codebuild"
  git_repository_name      = "forest"
  get_global_configuration = local.make_codebuild_global_configuration
  enable_notifications     = false

  privileged_mode          = true
  is_build_concurrent      = false
  specific_branch          = "main"
  environment_compute_type = "BUILD_GENERAL1_LARGE"
  codebuild_image          = "aws/codebuild/amazonlinux2-aarch64-standard:2.0"

  buildspec_logic  = file("${path.module}/templates/codebuild/deploy_forest_arm64.yaml")
  environment_type = "ARM_CONTAINER"

  depends_on = [
    aws_secretsmanager_secret.github_cd_token_secret
  ]
}
