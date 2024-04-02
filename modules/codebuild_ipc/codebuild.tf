resource "aws_codebuild_project" "codebuild" {
  name                   = "${module.generator.prefix}-${var.project_name}"
  description            = var.project_description
  build_timeout          = var.build_timeout
  service_role           = aws_iam_role.codebuild_role.arn
  source_version         = var.github_branch
  concurrent_build_limit = var.concurrent_build_limit
  badge_enabled          = var.badge_enabled


  artifacts {
    type = "S3"
    location = "${var.s3_bucket}"
    packaging = "ZIP"
    name = "${var.artifact_name}"
  }

  cache {
    type = "LOCAL"
    modes = [ "LOCAL_SOURCE_CACHE", "LOCAL_CUSTOM_CACHE" ]
  }

  environment {
    compute_type    = var.env_compute_type
    image           = var.env_image
    type            = var.env_type
    privileged_mode = var.env_privileged_mode

    dynamic "environment_variable" {
      for_each = var.environment_variables
      content {
        name  = environment_variable.key
        value = environment_variable.value
      }
    }
  }
  source {
    type = "GITHUB"

    location        = "https://github.com/${var.github_org}/${var.github_repo}.git"
    buildspec       = var.buildspec
    git_clone_depth = 1
  }

  tags = module.generator.common_tags
}

resource "aws_codebuild_source_credential" "token" {
  auth_type   = "PERSONAL_ACCESS_TOKEN"
  server_type = "GITHUB"
  token       = lookup(jsondecode(data.aws_secretsmanager_secret_version.git_credentials.secret_string), "github_token", null)
}
