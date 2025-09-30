locals {
  users = [
    {
      username = "arsenii@protofire.io",
      aws_account = [
        "devops"
      ],
      eks_access = {
         "${local.eks_cluster_mainnet}" = "${local.devops_role.eks_group}",
         "${local.eks_cluster_testnet}" = "${local.devops_role.eks_group}",
      },
    },
    {
      username = "uladzislau.muraveika@protofire.io",
      aws_account = [
        "devops"
      ],
      eks_access = {
        "${local.eks_cluster_mainnet}" = "${local.devops_role.eks_group}",
        "${local.eks_cluster_testnet}" = "${local.devops_role.eks_group}",
      },
    },
    {
      username = "ales.dumikau@protofire.io",
      aws_account = [
        "devops"
      ],
      eks_access = {
        "${local.eks_cluster_testnet}" = "${local.devops_role.eks_group}",
        "${local.eks_cluster_mainnet}" = "${local.devops_role.eks_group}",
      },
    },
    {
      username = "codebuild_user",
      aws_account = [
        "devops"
      ],
      eks_access = {
        "${local.eks_cluster_mainnet}" = "${local.devops_role.eks_group}",
        "${local.eks_cluster_testnet}" = "${local.devops_role.eks_group}",
      },
    },
    {
      username = "dzmitry.kliapkou@protofire.io",
      aws_account = [
        "devops"
      ],
      eks_access = {
        "${local.eks_cluster_testnet}" = "${local.devops_role.eks_group}",
        "${local.eks_cluster_mainnet}" = "${local.devops_role.eks_group}",
      },
    },
    {
      username = "ilya.velinsky@protofire.io",
      aws_account = [
        "devops"
      ],
      eks_access = {
        "${local.eks_cluster_testnet}" = "${local.devops_role.eks_group}",
        "${local.eks_cluster_mainnet}" = "${local.devops_role.eks_group}",
      },
    },
    {
      username = "braian@protofire.io",
      aws_account = [
        "devops"
      ],
      eks_access = {
        "${local.eks_cluster_testnet}" = "${local.devops_role.eks_group}",
        "${local.eks_cluster_mainnet}" = "${local.devops_role.eks_group}",
      },
    },
  ]
}
