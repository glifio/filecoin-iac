resource "kubernetes_namespace_v1" "default" {
  metadata {
    annotations = {
      "name" = var.kubernetes_namespace
    }
    name = var.kubernetes_namespace
  }
}
