# AWS group membership loops
resource "aws_iam_group_membership" "preprod_devops" {
  name = "${module.generator_global.prefix}-devops"

  users = [for user in local.users : aws_iam_user.users[user.username].name
    if contains(lookup(user, "aws_account", []), "devops")
  ]

  group = aws_iam_group.devops.name
}

resource "aws_iam_group_membership" "preprod_developers" {
  name = "${module.generator_global.prefix}-developers"

  users = [for user in local.users : aws_iam_user.users[user.username].name
    if contains(lookup(user, "aws_account", []), "developers")
  ]

  group = aws_iam_group.developers.name
}
