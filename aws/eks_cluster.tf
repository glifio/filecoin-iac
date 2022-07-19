resource "aws_eks_cluster" "main" {
  name                      = "${module.generator.prefix}-eks"
  version                   = var.eks_cluster_version
  role_arn                  = aws_iam_role.eks_master.arn
  enabled_cluster_log_types = ["api", "audit", "controllerManager"]

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]
    subnet_ids              = flatten([aws_subnet.public.*.id, aws_subnet.private.*.id])
    security_group_ids      = [aws_security_group.eks_sg.id]
  }

  kubernetes_network_config {
    service_ipv4_cidr = "10.100.0.0/16"
    ip_family         = "ipv4"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_policy,
    aws_iam_role_policy_attachment.eks_controller_policy,
    aws_cloudwatch_log_group.cloudwatch_eks_logs,
  ]

  tags = merge(
    {
      "Name" = "${module.generator.prefix}-eks-cluster"
    },
    module.generator.common_tags
  )
}


resource "aws_iam_role" "eks_master" {
  name               = "${module.generator.prefix}-EKS-master-role"
  description        = "${module.generator.prefix} EKS master role"
  assume_role_policy = file("${path.module}/templates/roles/eks_master_role.pol.tpl")

  tags = merge(
    {
      "Name" = "${module.generator.prefix}-eks-cluster-role"
    },
    module.generator.common_tags
  )
}

resource "aws_iam_role_policy_attachment" "eks_policy" {
  role       = aws_iam_role.eks_master.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_controller_policy" {
  role       = aws_iam_role.eks_master.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

resource "aws_iam_openid_connect_provider" "main" {
  url = aws_eks_cluster.main.identity[0].oidc[0].issuer

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = [data.tls_certificate.this.certificates[0].sha1_fingerprint]
}
