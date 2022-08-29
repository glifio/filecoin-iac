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


################## Devops Policies
resource "aws_iam_group_policy_attachment" "devops" {
  group      = aws_iam_group.devops.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_policy_attachment" "devops_group" {
  group      = aws_iam_group.devops.name
  policy_arn = aws_iam_policy.manage_own_credentials.arn
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
