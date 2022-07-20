resource "aws_codebuild_webhook" "webhook_codebuild_build" {
  count        = local.is_build_only
  project_name = aws_codebuild_project.codebuild.name

  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PULL_REQUEST_CREATED, PULL_REQUEST_UPDATED"
    }

    filter {
      type    = "BASE_REF"
      pattern = "refs/heads/${local.get_branch}"
    }
  }
}

resource "aws_codebuild_webhook" "webhook_codebuild_deploy" {
  count        = local.is_deploy_only
  project_name = aws_codebuild_project.codebuild.name

  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PUSH"
    }

    filter {
      type    = "HEAD_REF"
      pattern = "refs/heads/${local.get_branch}"
    }
  }
}
