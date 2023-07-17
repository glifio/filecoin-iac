resource "aws_security_group" "eks_nogroup_sg" {
  name        = "${module.generator.prefix}-${local.nodegroup_name_capacitated}-sg"
  description = "${module.generator.prefix} ${local.nodegroup_name_capacitated} security group"
  vpc_id      = local.vpc_id

  tags = merge(
    {
      "Name"                                                 = "${module.generator.prefix}-${local.nodegroup_name_capacitated}-sg",
      "kubernetes.io/cluster/${module.generator.prefix}-eks" = "owned"
    },
    module.generator.common_tags
  )
}

resource "aws_security_group_rule" "eks_sgr_ingress_itself" {
  type              = "ingress"
  description       = "${module.generator.prefix} ingress rule self to 0.0.0.0"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = [local.cidr_block]
  security_group_id = aws_security_group.eks_nogroup_sg.id
}

resource "aws_security_group_rule" "eks_sgr_ingress_ssh" {
  type              = "ingress"
  description       = "${module.generator.prefix} ingress ssh"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.eks_nogroup_sg.id
}


resource "aws_security_group_rule" "eks_sgr_ingress_http_endpoint" {
  type              = "ingress"
  description       = "${module.generator.prefix} ingress rule endpoint from 0.0.0.0"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.eks_nogroup_sg.id
}

resource "aws_security_group_rule" "eks_sgr_ingress_endpoint" {
  type              = "ingress"
  description       = "${module.generator.prefix} ingress rule endpoint from 0.0.0.0"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.eks_nogroup_sg.id
}

resource "aws_security_group_rule" "eks_sgr_egress_itself" {
  type              = "egress"
  description       = "${module.generator.prefix} egress rule self to 0.0.0.0"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.eks_nogroup_sg.id
}

resource "aws_security_group_rule" "eks_sgr_egress_nodes" {
  type              = "egress"
  description       = "${module.generator.prefix} egress nodes"
  from_port         = 1025
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = [local.cidr_block]
  security_group_id = aws_security_group.eks_nogroup_sg.id
}
