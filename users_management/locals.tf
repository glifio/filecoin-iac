locals {
  eks_cluster_testnet = "${module.generator_dev.prefix}-eks"
  eks_cluster_mainnet = "${module.generator_mainnet.prefix}-eks"
  
  devops_role = {
    aws_policies = ["arn:aws:iam::aws:policy/AdministratorAccess", aws_iam_policy.manage_own_credentials.arn]
    eks_group  = "system:masters"
  }

  developers_role = {
    aws_policies = ["arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess", aws_iam_policy.manage_own_credentials.arn, aws_iam_policy.eks_devs.arn]
    eks_group  = "default_admin_group"
  }
}
