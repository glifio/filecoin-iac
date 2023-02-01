resource "aws_codebuild_webhook" "webhook_codebuild_build" {
  count        = local.create_build_webhook
  build_type   = "BUILD"
  project_name = aws_codebuild_project.codebuild.name

  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PULL_REQUEST_CREATED, PULL_REQUEST_UPDATED"
    }

    filter {
      type    = "BASE_REF"
      pattern = local.webhhok_custom_type
    }
  }
}

resource "aws_codebuild_webhook" "webhook_codebuild_deploy" {
  count        = local.create_deploy_webhook
  build_type   = "BUILD"
  project_name = aws_codebuild_project.codebuild.name

  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PUSH"
    }

    filter {
      type    = "HEAD_REF"
      pattern = local.webhhok_custom_type
    }
  }
}
