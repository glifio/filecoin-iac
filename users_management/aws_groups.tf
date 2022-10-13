resource "aws_iam_group" "devops" {
  name = "${module.generator_global.prefix}-devops"
}

resource "aws_iam_group" "developers" {
  name = "${module.generator_global.prefix}-developers"
}

