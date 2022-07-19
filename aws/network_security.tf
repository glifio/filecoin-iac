resource "aws_network_acl" "public_nacl" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = flatten([aws_subnet.public.*.id])

  egress {
    rule_no    = 200
    action     = "allow"
    protocol   = -1
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    rule_no    = 200
    action     = "allow"
    protocol   = -1
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = merge({ "Name" = "${module.generator.prefix}-public-nacl" },
    module.generator.common_tags
  )
}


resource "aws_network_acl" "private_nacl" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = flatten([aws_subnet.private.*.id])

  egress {
    rule_no    = 200
    action     = "allow"
    protocol   = -1
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    rule_no    = 200
    action     = "allow"
    protocol   = -1
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = merge({ "Name" = "${module.generator.prefix}-private-nacl" },
    module.generator.common_tags
  )
}


#https://docs.aws.amazon.com/eks/latest/userguide/sec-group-reqs.html

resource "aws_security_group" "eks_sg" {
  name        = "${module.generator.prefix}-eks-master-sg"
  description = "${module.generator.prefix} EKS security group"
  vpc_id      = aws_vpc.main.id

  tags = merge({ "Name" = "${module.generator.prefix}-eks-master-sg" },
    module.generator.common_tags
  )
}

resource "aws_security_group_rule" "eks_sgr_ingress_itself" {
  type              = "ingress"
  description       = "${module.generator.prefix} ingress rule self to 0.0.0.0"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = [aws_vpc.main.cidr_block]
  security_group_id = aws_security_group.eks_sg.id
}

resource "aws_security_group_rule" "eks_sgr_ingress_https_endpoint" {
  type              = "ingress"
  description       = "${module.generator.prefix} ingress rule endpoint from 0.0.0.0"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.eks_sg.id
}

resource "aws_security_group_rule" "eks_sgr_egress_itself" {
  type              = "egress"
  description       = "${module.generator.prefix} egress rule self to 0.0.0.0"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.eks_sg.id
}

resource "aws_security_group_rule" "eks_sgr_egress_nodes" {
  type              = "egress"
  description       = "${module.generator.prefix} egress nodes"
  from_port         = 1025
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.main.cidr_block]
  security_group_id = aws_security_group.eks_sg.id
}
