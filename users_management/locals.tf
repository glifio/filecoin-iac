locals {
  eks_cluster_testnet = "${module.generator_dev.prefix}-eks"
  eks_cluster_mainnet = "${module.generator_mainnet.prefix}-eks"
  
  devops_role = {
    aws_policy = "arn:aws:iam::aws:policy/AdministratorAccess" 
    eks_group  = "system:masters"
  }

  developers_role = {
    aws_policy = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
    eks_group  = "default-namespace-admin"
  }
}
