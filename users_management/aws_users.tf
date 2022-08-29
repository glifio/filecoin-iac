# AWS user creation loops
resource "aws_iam_user" "users" {

  for_each = { for user in local.users :
  user.username => user.username }

  name          = each.value
  force_destroy = true

  tags = module.generator_global.common_tags
}
