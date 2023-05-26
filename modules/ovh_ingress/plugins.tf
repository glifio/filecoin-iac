resource "kubernetes_manifest" "request_transformer-path_transformer" {
  count = local.path_transformer_count

  manifest = {
    apiVersion = "configuration.konghq.com/v1"
    kind       = "KongPlugin"
    metadata = {
      name      = local.path_transformer_available_name
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

resource "kubernetes_manifest" "request_transformer-public_access_add" {
  count = local.public_access_add_count

  manifest = {
    apiVersion = "configuration.konghq.com/v1"
    kind       = "KongPlugin"
    metadata = {
      name      = local.public_access_add_available_name
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

resource "kubernetes_manifest" "request_transformer-public_access_replace" {
  count = local.public_access_replace_count

  manifest = {
    apiVersion = "configuration.konghq.com/v1"
    kind       = "KongPlugin"
    metadata = {
      name      = local.public_access_replace_available_name
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
        headers = [
          "Authorization: Bearer ${local.auth_token}"
        ]
      }
    }
  }
}

resource "kubernetes_manifest" "request_transformer-private_access_add" {
  count = local.private_access_add_count

  manifest = {
    apiVersion = "configuration.konghq.com/v1"
    kind       = "KongPlugin"
    metadata = {
      name      = local.private_access_add_available_name
      namespace = var.namespace
    }

    plugin = "request-transformer"

    config = {
      add = {
        headers = [
          "Authorization: false"
        ]
      }
    }
  }
}

resource "kubernetes_manifest" "request_transformer-private_access_replace" {
  count = local.private_access_replace_count

  manifest = {
    apiVersion = "configuration.konghq.com/v1"
    kind       = "KongPlugin"
    metadata = {
      name      = local.private_access_replace_available_name
      namespace = var.namespace
    }

    plugin = "request-transformer"

    config = {
      add = {
        headers = [
          "Authorization: false"
        ]
      }
      replace = {
        headers = [
          "Authorization: false"
        ]
      }
    }
  }
}

resource "kubernetes_manifest" "request_transformer-path_transformer_public_access_add" {
  count = local.path_transformer_public_access_add_count

  manifest = {
    apiVersion = "configuration.konghq.com/v1"
    kind       = "KongPlugin"
    metadata = {
      name      = local.path_transformer_public_access_add_available_name
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

resource "kubernetes_manifest" "request_transformer-path_transformer_public_access_replace" {
  count = local.path_transformer_public_access_replace_count

  manifest = {
    apiVersion = "configuration.konghq.com/v1"
    kind       = "KongPlugin"
    metadata = {
      name      = local.path_transformer_public_access_replace_available_name
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
        headers = [
          "Authorization: Bearer ${local.auth_token}"
        ]
        uri = var.replace_path_rule
      }
    }
  }
}

resource "kubernetes_manifest" "request_transformer-path_transformer_private_access_add" {
  count = local.path_transformer_private_access_add_count

  manifest = {
    apiVersion = "configuration.konghq.com/v1"
    kind       = "KongPlugin"
    metadata = {
      name      = local.path_transformer_private_access_add_available_name
      namespace = var.namespace
    }

    plugin = "request-transformer"

    config = {
      add = {
        headers = [
          "Authorization: false"
        ]
      }
      replace = {
        uri = var.replace_path_rule
      }
    }
  }
}

resource "kubernetes_manifest" "request_transformer-path_transformer_private_access_replace" {
  count = local.path_transformer_private_access_replace_count

  manifest = {
    apiVersion = "configuration.konghq.com/v1"
    kind       = "KongPlugin"
    metadata = {
      name      = local.path_transformer_private_access_replace_available_name
      namespace = var.namespace
    }

    plugin = "request-transformer"

    config = {
      add = {
        headers = [
          "Authorization: false"
        ]
      }
      replace = {
        headers = [
          "Authorization: false"
        ]
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
      name      = local.cors_available_name
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
      name      = local.return_json_available_name
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
