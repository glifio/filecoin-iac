resource "aws_iam_group" "devops" {
  name = "${module.generator.prefix}-devops"
}

