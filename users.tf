locals {
  users = [
    {
      username = "alexey.kulik@protofire.io",
      aws_account = [
        "devops"
      ],
      eks_access = {
        "${local.eks_cluster_mainnet}" = "${local.devops_role.eks_group}",
        "${local.eks_cluster_testnet}" = "${local.devops_role.eks_group}",
      },
    },
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
      username = "aliaksandr.nosau@protofire.io",
      aws_account = [
        "developers"
      ],
      eks_access = {
        "${local.eks_cluster_mainnet}" = "${local.developers_role.eks_group}",
        "${local.eks_cluster_testnet}" = "${local.developers_role.eks_group}",
      },
    },
    {
      username = "vitaliy.chernov@protofire.io",
      aws_account = [
        "developers"
      ],
      eks_access = {
        "${local.eks_cluster_mainnet}" = "${local.developers_role.eks_group}",
        "${local.eks_cluster_testnet}" = "${local.developers_role.eks_group}",
      },
    },
  ]
}
