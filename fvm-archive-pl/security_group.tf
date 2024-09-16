resource "aws_security_group" "default" {
  name        = "fvm-archive-pl"
  description = "Allow SSH and RPC access to the node to the PL team"
  vpc_id      = data.aws_vpc.default.id

  tags = merge(var.common_tags, {
    Name = "${var.resource_prefix}-default-security-group"
  })
}

resource "aws_security_group_rule" "ingress_allow_all" {
  type              = "ingress"
  security_group_id = aws_security_group.default.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}

resource "aws_security_group_rule" "egress_allow_all" {
  type              = "egress"
  security_group_id = aws_security_group.default.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}
