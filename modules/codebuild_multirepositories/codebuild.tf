resource "aws_codebuild_project" "codebuild" {
  name                   = local.make_codebuild_current_name
  description            = local.make_codebuild_description
  build_timeout          = var.build_timeout
  service_role           = aws_iam_role.codebuild_role.arn
  source_version         = local.selected_branch
  concurrent_build_limit = local.get_build_concurrent_count
  badge_enabled          = var.badge_enabled


  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type    = var.environment_compute_type
    image           = var.codebuild_image
    type            = "ARM_CONTAINER"
    privileged_mode = var.privileged_mode

    dynamic "environment_variable" {
      for_each = local.make_environment_variables
      content {
        name  = environment_variable.key
        value = environment_variable.value
      }
    }
  }
  source {
    type            = "GITHUB"
    location        = "https://github.com/${local.git_config[0].organization_name}/${local.git_config[0].repo_name}.git"
    buildspec       = local.get_codebuildspec_logic
    git_clone_depth = 1
  }

  secondary_sources {
    type              = "GITHUB"
    source_identifier = "SECOND"
    location          = "https://github.com/glifio/filecoin-docker.git"
    git_clone_depth   = 1
  }

  secondary_source_version {
    source_identifier = "SECOND"
    source_version    = "build_file_for_wallaby"
  }


  tags = module.generator.common_tags
}

resource "aws_codebuild_source_credential" "token" {
  auth_type   = "PERSONAL_ACCESS_TOKEN"
  server_type = "GITHUB"
  token       = local.github_token
}
