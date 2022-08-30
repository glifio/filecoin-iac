data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "k8s_cluster_testnet" {
  name = local.eks_cluster_testnet
}

data "aws_eks_cluster_auth" "k8s_cluster_auth_testnet" {
  name = local.eks_cluster_testnet
}

data "aws_eks_cluster" "k8s_cluster_mainnet" {
  name = local.eks_cluster_mainnet
}

data "aws_eks_cluster_auth" "k8s_cluster_auth_mainnet" {
  name = local.eks_cluster_mainnet
}
