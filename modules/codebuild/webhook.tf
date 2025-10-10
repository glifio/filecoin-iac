resource "aws_codebuild_webhook" "webhook_codebuild_build" {
  build_type   = "BUILD"
  count        = var.enable_webhook && var.is_build_only ? 1 : 0
  project_name = aws_codebuild_project.codebuild.name

  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PULL_REQUEST_CREATED, PULL_REQUEST_UPDATED"
    }

    filter {
      type    = "BASE_REF"
      pattern = "refs/heads/${local.selected_branch}"
    }
  }
}

resource "aws_codebuild_webhook" "webhook_codebuild_deploy" {
  build_type   = "BUILD"
  count        = var.enable_webhook && !var.is_build_only ? 1 : 0
  project_name = aws_codebuild_project.codebuild.name

  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PUSH"
    }

    filter {
      type    = "HEAD_REF"
      pattern = "refs/heads/${local.selected_branch}"
    }
  }
}
