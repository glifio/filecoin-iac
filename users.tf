locals {
  users = [
    {
      username = "alexey.kulik@protofire.io",
      aws_account = [
        "devops"
      ],
      eks_access = [
        local.eks_cluster_testnet,
        local.eks_cluster_mainnet,
      ],
    },
    {
      username = "arsenii@protofire.io",
      aws_account = [
        "devops"
      ],
      eks_access = [
        local.eks_cluster_testnet,
        local.eks_cluster_mainnet,
      ],
    },
    {
      username = "uladzislau.muraveika@protofire.io",
      aws_account = [
        "devops"
      ],
      eks_access = [
        local.eks_cluster_testnet,
        local.eks_cluster_mainnet,
      ],
    },
  ]
}
