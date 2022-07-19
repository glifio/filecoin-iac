data "aws_subnet" "selected" {
  id = local.get_subnet_id
}
