resource "aws_eks_node_group" "nodegroup" {
  cluster_name         = local.get_cluster_name
  node_group_name      = "${module.generator.prefix}-${local.join_nodegrpup_name_capacity_type}"
  node_role_arn        = aws_iam_role.eks_nodegroup.arn
  subnet_ids           = flatten([local.get_subnet_id])
  ami_type             = var.ami_type
  instance_types       = split(",", var.get_instance_type)
  capacity_type        = var.is_spot_instance ? "SPOT" : null
  force_update_version = true

  launch_template {
    id      = local.get_launch_template
    version = local.get_launch_template_version
  }

  scaling_config {
    desired_size = var.get_desired_size # 1
    max_size     = var.get_max_size     # 2
    min_size     = var.get_min_size     # 1
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_nodegroup_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks_nodegroup_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks_nodegroup_AmazonEC2ContainerRegistryReadOnly,
  ]

  lifecycle {
    ignore_changes = [
      scaling_config[0].desired_size,
    ]
  }

  labels = local.make_custom_k8s_labels

  tags = merge(
    {
      "Name"          = "${module.generator.prefix}-${local.join_nodegrpup_name_capacity_type}"
      "nodeGroupName" = local.get_nodegroup_postfix
    },
    module.generator.common_tags
  )
}

resource "aws_iam_role" "eks_nodegroup" {
  name               = "${module.generator.prefix}-${local.join_nodegrpup_name_capacity_type}"
  assume_role_policy = file("${path.module}/templates/roles/eks_nodegroup_role.pol.tpl")
}

resource "aws_iam_role_policy_attachment" "eks_nodegroup_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodegroup.name
}

resource "aws_iam_role_policy_attachment" "eks_nodegroup_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodegroup.name
}

resource "aws_iam_role_policy_attachment" "eks_nodegroup_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodegroup.name
}

resource "aws_iam_policy" "attach_ebs" {
  count  = var.use_existing_ebs ? 1 : 0
  name   = "${module.generator.prefix}-attach-ebs-${local.get_nodegroup_postfix}"
  policy = file("${path.module}/templates/policies/attach_ebs_volumes_policy.tpl")

  tags = module.generator.common_tags
}

resource "aws_iam_role_policy_attachment" "attach_ebs" {
  count      = var.use_existing_ebs ? 1 : 0
  policy_arn = aws_iam_policy.attach_ebs[0].arn
  role       = aws_iam_role.eks_nodegroup.name
}
