resource "kubernetes_namespace_v1" "network" {
  metadata {
    annotations = {
      "name" = "network"
    }
    labels = {
      app = "lotus-node-app"
    }
    name = "network"
  }
}

resource "kubernetes_namespace_v1" "monitoring" {
  metadata {
    annotations = {
      "name" = "monitoring"
    }
    name = "monitoring"
  }
}

resource "kubernetes_namespace_v1" "logging" {
  metadata {
    annotations = {
      "name" = "logging"
    }
    name = "logging"
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

resource "kubernetes_namespace_v1" "ingress_nginx" {
  metadata {
    annotations = {
      "app.kubernetes.io/instance" = "ingress-nginx"
      "app.kubernetes.io/name"     = "ingress-nginx"
    }
    labels = {
      "app.kubernetes.io/instance" = "ingress-nginx"
      "app.kubernetes.io/name"     = "ingress-nginx"
    }
    name = "ingress-nginx"
  }
}
