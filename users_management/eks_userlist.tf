resource "kubernetes_config_map_v1_data" "users_list_testnet" {
  provider = kubernetes.k8s_cluster_testnet
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
  data = {
    "mapUsers" = templatefile("${path.module}/configs/user_management/eks_users_list.yaml", {
      aws_account_id = data.aws_caller_identity.current.account_id,
      get_users = [for user in local.users : user.username
        if contains(lookup(user, "eks_access", []), local.eks_cluster_testnet)
      ]
    })
  }
  force = true
}


resource "kubernetes_config_map_v1_data" "users_list_mainnet" {
  provider = kubernetes.k8s_cluster_mainnet
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
  data = {
    "mapUsers" = templatefile("${path.module}/configs/user_management/eks_users_list.yaml", {
      aws_account_id = data.aws_caller_identity.current.account_id,
      get_users = [for user in local.users : user.username
      if contains(lookup(user, "eks_access", []), local.eks_cluster_mainnet)
      ]
    })
  }
  force = true
}

