resource "kubernetes_service" "homepage" {
  metadata {
    name      = "${local.prefix}-homepage"
    namespace = var.namespace
  }

  spec {
    port {
      name     = "http"
      protocol = "TCP"
      port     = 80
    }
    port {
      name     = "https"
      protocol = "TCP"
      port     = 443
    }
    type          = "ExternalName"
    external_name = local.domain_names.homepage
  }
}

resource "kubernetes_service" "circulating_supply" {
  metadata {
    name      = "${local.prefix}-circulatingsupply"
    namespace = var.namespace
  }

  spec {
    port {
      name     = "http"
      protocol = "TCP"
      port     = 80
    }
    port {
      name     = "https"
      protocol = "TCP"
      port     = 443
    }
    type          = "ExternalName"
    external_name = local.domain_names.circulating_supply
  }
}

resource "kubernetes_service" "circulating_supply_staging" {
  metadata {
    name      = "${local.prefix}-circulatingsupply-staging"
    namespace = var.namespace
  }

  spec {
    port {
      name     = "http"
      protocol = "TCP"
      port     = 80
    }
    port {
      name     = "https"
      protocol = "TCP"
      port     = 443
    }
    type          = "ExternalName"
    external_name = local.domain_names.circulating_supply_staging
  }
}
