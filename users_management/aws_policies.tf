resource "aws_iam_account_password_policy" "main" {
  allow_users_to_change_password = true
  hard_expiry                    = false
  max_password_age               = 90
  minimum_password_length        = 14
  password_reuse_prevention      = 24
  require_lowercase_characters   = true
  require_uppercase_characters   = true
  require_numbers                = true
  require_symbols                = true
}

################## Developer Policies
resource "aws_iam_group_policy_attachment" "developers" {
  count      = length(local.developers_role.aws_policies)
  group      = aws_iam_group.developers.name
  policy_arn = local.developers_role.aws_policies[count.index]
}

################## Devops Policies
resource "aws_iam_group_policy_attachment" "devops" {
  count      = length(local.devops_role.aws_policies)
  group      = aws_iam_group.devops.name
  policy_arn = local.devops_role.aws_policies[count.index] 
}

################## Base Policies

# https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_users-self-manage-mfa-and-creds.html
resource "aws_iam_policy" "manage_own_credentials" {
  name        = "${module.generator_global.prefix}-manage-own-credentials"
  description = "Policy to allow users to manage their own credentials"
  path        = "/"
  policy      = file("${path.module}/policies/manage_own_credentials.pol.tpl")

  tags = module.generator_global.common_tags
}

# https://computingforgeeks.com/grant-developers-access-to-eks-kubernetes-cluster/
resource "aws_iam_policy" "eks_devs" {
  name        = "${module.generator_global.prefix}-connect-to-eks"
  description = "Policy to allow developers to connect to EKS cluster"
  path        = "/"
  policy      = file("${path.module}/policies/eks_devs.pol.tpl")

  tags = module.generator_global.common_tags
}
