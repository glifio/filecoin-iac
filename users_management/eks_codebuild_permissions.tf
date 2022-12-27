# Role with basic permissions for CodeBuild 
resource "kubernetes_role" "codebuild_wallaby" {
  provider = kubernetes.k8s_cluster_mainnet
  metadata {
    name      = "codebuild_wallaby_role"
    namespace = "network"
  }

  rule {
    api_groups = ["apps"]
    resources  = ["statefulsets", "statefulsets/scale"]
    verbs      = ["get", "patch"]
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get", "list", "watch"]
  }

  # Kubernetes currently doesn't support refering to resources by name prefixes
  # nor it supports doing that by labels, so each time a new pvc of wallaby 
  # is created or changed, it has to be added below
  # in order for CodeBuild to work
  rule {
    api_groups = [""]
    resources  = ["persistentvolumeclaims"]
    resource_names = [
      "vol-lotus-wallaby-archive-lotus-0",
      "vol-lotus-wallaby-archive-private-0-lotus-0",
      "vol-lotus-wallaby-archive-slave-1-lotus-0",
      "vol-lotus-wallaby-archive-slave-lotus-0"
    ]
    verbs = ["delete"]
  }
}

resource "kubernetes_role_binding" "codebuild_wallaby" {
  provider = kubernetes.k8s_cluster_mainnet
  metadata {
    name      = "codebuild_wallaby_rolebinding"
    namespace = "network"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "codebuild_wallaby_role"
  }
  subject {
    kind      = "Group"
    name      = local.codebuild_wallaby_role.eks_group
    api_group = "rbac.authorization.k8s.io"
  }
}
