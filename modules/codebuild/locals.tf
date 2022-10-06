locals {
  get_project           = lookup(var.get_global_configuration, "project", "")
  get_region            = lookup(var.get_global_configuration, "region", "")
  get_environment       = lookup(var.get_global_configuration, "environment", "")
  get_sub_environment   = lookup(var.get_global_configuration, "sub_environment", "")
  get_aws_account_id    = lookup(var.get_global_configuration, "aws_account_id", "")
  get_branch            = lookup(var.get_global_configuration, "branch", "")
  get_git_configuration = lookup(var.get_global_configuration, "git_configuration", "")

  selected_branch = var.specific_branch == null ? local.get_branch : var.specific_branch

  make_environment_variables = {
    PROJECT         = local.get_project
    SUB_ENVIRONMENT = local.get_sub_environment
    REGION          = local.get_region
    REGION_SHORT    = module.generator.region_short
    ENVIRONMENT     = local.get_environment
    AWS_ACCOUNT_ID  = local.get_aws_account_id
    IS_BUILD_ONLY   = var.is_build_only ? "1" : "0"
  }

  git_config = [for project in local.get_git_configuration : project.config
    if contains(values(lookup(project, "config", [])), var.git_repository_name)
  ]

  get_codebuildspec_file  = var.is_build_only ? "buildspec.ci.yaml" : "buildspec.yaml"
  is_build_only           = var.is_build_only ? 1 : 0
  is_deploy_only          = !var.is_build_only ? 1 : 0

  codebuild_name              = "${module.generator.prefix}-${local.git_config[0].project_name}-codebuild"
  make_codebuild_current_name = var.is_build_only ? "${local.codebuild_name}-build" : "${local.codebuild_name}-deploy"
  make_codebuild_description  = var.is_build_only ? "${local.git_config[0].description}-build" : "${local.git_config[0].description}-deploy"
  github_token                = lookup(jsondecode(data.aws_secretsmanager_secret_version.git_credentials.secret_string), "github_token", null)
  get_build_concurrent_count  = var.is_build_concurrent ? var.concurrent_build_limit : var.concurrent_build_limit_default
}
