resource "kubernetes_role" "default_namespace_admin_testnet" {
  provider = kubernetes.k8s_cluster_testnet
  metadata {
    name = "default-namespace-admin"
    namespace = "default"
  }

  rule {
    api_groups     = [""]
    resources      = ["*"]
    resource_names = ["*"]
    verbs          = ["*"]
  }
}

resource "kubernetes_role_binding" "default_namespace_admin_testnet" {
  provider = kubernetes.k8s_cluster_testnet
  metadata {
    name      = "default_namespace_admin"
    namespace = "default"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "default-namespace-admin"
  }
  subject {
    kind      = "Group"
    name      = "default-namespace-admin"
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "kubernetes_role" "default_namespace_admin_mainnet" {
  provider = kubernetes.k8s_cluster_mainnet
  metadata {
    name = "default-namespace-admin"
    namespace = "default"
  }

  rule {
    api_groups     = [""]
    resources      = ["*"]
    resource_names = ["*"]
    verbs          = ["*"]
  }
}

resource "kubernetes_role_binding" "default_namespace_admin_mainnet" {
  provider = kubernetes.k8s_cluster_mainnet
  metadata {
    name      = "default_namespace_admin"
    namespace = "default"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "default-namespace-admin"
  }
  subject {
    kind      = "Group"
    name      = "default-namespace-admin"
    api_group = "rbac.authorization.k8s.io"
  }
}
