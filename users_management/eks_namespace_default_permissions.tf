resource "kubernetes_role" "default_namespace_admin_testnet" {
  provider = kubernetes.k8s_cluster_testnet
  metadata {
    name = "default_admin_role"
    namespace = "default"
  }

  rule {
    api_groups     = [""]
    resources      = ["*"]
    verbs          = ["*"]
  }
}

resource "kubernetes_role_binding" "default_namespace_admin_testnet" {
  provider = kubernetes.k8s_cluster_testnet
  metadata {
    name      = "default_admin_rolebinding"
    namespace = "default"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "default_admin_role"
  }
  subject {
    kind      = "Group"
    name      = local.developers_role.eks_group
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "kubernetes_role" "default_namespace_admin_mainnet" {
  provider = kubernetes.k8s_cluster_mainnet
  metadata {
    name = "default_admin_role"
    namespace = "default"
  }

  rule {
    api_groups     = [""]
    resources      = ["*"]
    verbs          = ["*"]
  }
}

resource "kubernetes_role_binding" "default_namespace_admin_mainnet" {
  provider = kubernetes.k8s_cluster_mainnet
  metadata {
    name      = "default_admin_rolebinding"
    namespace = "default"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "default_admin_role"
  }
  subject {
    kind      = "Group"
    name      = local.developers_role.eks_group 
    api_group = "rbac.authorization.k8s.io"
  }
}
