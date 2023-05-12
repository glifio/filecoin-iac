resource "kubernetes_manifest" "request_transformer-public_access" {
  count = local.public_access_count

  manifest = {
    apiVersion = "configuration.konghq.com/v1"
    kind       = "KongPlugin"
    metadata = {
      name      = "${var.name}-public-access"
      namespace = var.namespace
    }

    plugin = "request-transformer"

    config = {
      add = {
        headers = [
          "Authorization: Bearer ${local.auth_token}"
        ]
      }
    }
  }
}

resource "kubernetes_manifest" "request_transformer-path_transformer" {
  count = local.path_transformer_count

  manifest = {
    apiVersion = "configuration.konghq.com/v1"
    kind       = "KongPlugin"
    metadata = {
      name      = "${var.name}-path-transformer"
      namespace = var.namespace
    }

    plugin = "request-transformer"

    config = {
      replace = {
        uri = var.replace_path_rule
      }
    }
  }
}

resource "kubernetes_manifest" "request_transformer-combined_transformer" {
  count = local.combined_transformer_count

  manifest = {
    apiVersion = "configuration.konghq.com/v1"
    kind       = "KongPlugin"
    metadata = {
      name      = "${var.name}-combined-transformer"
      namespace = var.namespace
    }

    plugin = "request-transformer"

    config = {
      add = {
        headers = [
          "Authorization: Bearer ${local.auth_token}"
        ]
      }

      replace = {
        uri = var.replace_path_rule
      }
    }
  }
}

resource "kubernetes_manifest" "cors" {
  count = local.cors_count

  manifest = {
    apiVersion = "configuration.konghq.com/v1"
    kind       = "KongPlugin"
    metadata = {
      name      = "${var.name}-cors"
      namespace = var.namespace
    }

    plugin = "cors"

    config = {
      origins = [
        "*"
      ]

      headers = [
        "Authorization",
        "Accept",
        "Origin",
        "DNT",
        "X-CustomHeader",
        "Keep-Alive",
        "User-Agent",
        "X-Requested-With",
        "If-Modified-Since",
        "Cache-Control",
        "Content-Type",
        "Content-Length",
        "Content-Range",
        "Range"
      ]
    }
  }
}

resource "kubernetes_manifest" "response_transformer-return_json" {
  count = local.return_json_count

  manifest = {
    apiVersion = "configuration.konghq.com/v1"
    kind       = "KongPlugin"
    metadata = {
      name      = "${var.name}-return-json"
      namespace = var.namespace
    }

    plugin = "response-transformer"

    config = {
      add = {
        headers = [
          "Content-Type:application/json"
        ]
      }

      replace = {
        headers = [
          "Content-Type:application/json"
        ]
      }
    }
  }
}
