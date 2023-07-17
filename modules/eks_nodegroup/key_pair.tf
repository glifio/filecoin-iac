resource "aws_key_pair" "eks_node" {
  key_name   = "${module.generator.prefix}-${local.nodegroup_name}-ssh"
  public_key = var.public_key
}
