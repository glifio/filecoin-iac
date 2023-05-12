resource "kubernetes_namespace_v1" "network" {
  metadata {
    annotations = {
      "name" = "network"
    }
    name = "network"
  }
}

resource "kubernetes_namespace_v1" "kong" {
  metadata {
    annotations = {
      "name" = "kong"
    }
    name = "kong"
  }
}
