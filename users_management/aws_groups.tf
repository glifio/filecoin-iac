resource "aws_iam_group" "devops" {
  name = "${module.generator_global.prefix}-devops"
}

