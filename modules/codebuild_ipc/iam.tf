data "aws_iam_policy_document" "codebuild_assume_role_policy" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "codebuild_role" {
  name               = "${module.generator.prefix}-${var.project_name}-codebuild-role"
  assume_role_policy = data.aws_iam_policy_document.codebuild_assume_role_policy.json
  tags               = module.generator.common_tags
}

data "aws_iam_policy_document" "codebuild_policy" {
  statement {
    sid = "BasicPermissions"

    actions = [
      "secretsmanager:*",
      "ssm:*",
      "logs:*",
      "kms:*",
      "codeartifact:GetAuthorizationToken",
      "codeartifact:GetRepositoryEndpoint",
      "codeartifact:ReadFromRepository",
      "sts:GetServiceBearerToken"
    ]

    resources = ["*"]
  }

  statement {
    sid = "S3Permissions"

    actions = [
      "s3:*"
    ]

    resources = [
      "arn:aws:s3:::${var.s3_bucket}",
      "arn:aws:s3:::${var.s3_bucket}/*"
    ]
  }
}

resource "aws_iam_policy" "codebuild_policy" {
  name   = "${module.generator.prefix}-${var.project_name}-codebuild-policy"
  policy = data.aws_iam_policy_document.codebuild_policy.json
  tags   = module.generator.common_tags
}

resource "aws_iam_role_policy_attachment" "codebuild_policy_attachment" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = aws_iam_policy.codebuild_policy.arn
}

resource "aws_iam_role_policy_attachment" "codebuild_ecr_policy_attachment" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}
