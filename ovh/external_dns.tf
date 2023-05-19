resource "kubernetes_deployment" "external_dns" {
  metadata {
    name      = local.external_dns.name
    namespace = local.external_dns.namespace
    labels = {
      "app.kubernetes.io/name" = local.external_dns.name
    }
  }

  spec {
    strategy {
      type = "Recreate"
    }

    selector {
      match_labels = {
        "app.kubernetes.io/name" = local.external_dns.name
      }
    }

    template {
      metadata {
        labels = {
          "app.kubernetes.io/name" = local.external_dns.name
        }
      }

      spec {
        service_account_name = kubernetes_service_account.external_dns.metadata.0.name
        container {
          name  = local.external_dns.name
          image = "registry.k8s.io/external-dns/external-dns:v0.13.4"
          args = [
            "--source=ingress",
            "--provider=aws",
            "--policy=upsert-only",
            "--registry=txt",
            "--txt-owner-id=external-dns"
          ]

          env {
            name  = "AWS_DEFAULT_REGION"
            value = local.external_dns.default_region
          }

          env {
            name  = "AWS_SHARED_CREDENTIALS_FILE"
            value = "/.aws/credentials"
          }

          volume_mount {
            name       = local.external_dns.name
            mount_path = "/.aws"
            read_only  = true
          }
        }

        volume {
          name = local.external_dns.name
          secret {
            secret_name = kubernetes_secret.external_dns_aws_credentials.metadata.0.name
          }
        }
      }
    }
  }
}

resource "kubernetes_service_account" "external_dns" {
  metadata {
    name = "${local.external_dns.name}-sa"
    labels = {
      "app.kubernetes.io/name" = "${local.external_dns.name}-sa"
    }
  }
}

resource "kubernetes_cluster_role" "external_dns" {
  metadata {
    name = "${local.external_dns.name}-role"
    labels = {
      "app.kubernetes.io/name" = "${local.external_dns.name}-role"
    }
  }

  rule {
    api_groups = ["extensions", "networking.k8s.io"]
    resources  = ["ingresses"]
    verbs      = ["get", "watch", "list"]
  }
}

resource "kubernetes_cluster_role_binding" "external_dns" {
  metadata {
    name = "${local.external_dns.name}-role-binding"
    labels = {
      "app.kubernetes.io/name" = "${local.external_dns.name}-role-binding"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.external_dns.metadata.0.name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.external_dns.metadata.0.name
    namespace = local.external_dns.namespace
  }
}

resource "kubernetes_secret" "external_dns_aws_credentials" {
  metadata {
    name      = "${local.external_dns.name}-aws-credentials"
    namespace = local.external_dns.namespace
    labels = {
      "app.kubernetes.io/name" = "${local.external_dns.name}-aws-credentials"
    }
  }

  data = {
    "credentials" = "${templatefile("${path.module}/config/aws/credentials", {
      id     = aws_iam_access_key.external_dns.id,
      secret = aws_iam_access_key.external_dns.secret
    })}"
  }
}
