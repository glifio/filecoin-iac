resource "aws_key_pair" "eks_node" {
  key_name   = "${module.generator.prefix}-${local.get_nodegroup_postfix}-ssh"
  public_key = var.public_key
}
