resource "kubernetes_config_map_v1_data" "users_list" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
  data = {
    "mapUsers" = templatefile("${path.module}/configs/user_management/eks_users_list.yaml", {
      aws_account_id = data.aws_caller_identity.current.account_id
    })
  }
  force = true
}
