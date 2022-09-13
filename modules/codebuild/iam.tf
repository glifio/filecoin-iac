resource "aws_iam_role" "codebuild_role" {
  name               = "${module.generator.prefix}-${random_string.uid.result}-codebuild-general"
  assume_role_policy = file("${path.module}/templates/roles/codebuild.pol.tpl")

  tags = module.generator.common_tags
}

// Start Block Codebuild CI policy
resource "aws_iam_policy" "codebuild_policy" {
  name = "${module.generator.prefix}-${random_string.uid.result}-codebuild-general"
  policy = templatefile("${path.module}/templates/policies/codebuild_general.pol.tpl", {
    account_id              = local.get_aws_account_id
    aws_region              = local.get_region
    generate_prefix         = module.generator.prefix
    generate_prefix_account = module.generator.prefix_account
    project_name            = local.get_project
  })

  tags = module.generator.common_tags
}

resource "aws_iam_role_policy_attachment" "codebuild_role-policy-attachment" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = aws_iam_policy.codebuild_policy.arn
}

resource "aws_iam_role_policy_attachment" "codebuild_role-ecr-policy-attachment" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}
