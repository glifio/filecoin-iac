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

resource "kubernetes_manifest" "rate_limiting" {
  count = local.limit_reqs_wo_header_count

  manifest = {
    apiVersion = "configuration.konghq.com/v1"
    kind       = "KongPlugin"
    metadata = {
      name      = local.limit_reqs_wo_header_available_name
      namespace = var.namespace
    }

    plugin = "rate-limiting"

    config = {
      policy = "local"
      minute = 100
    }
  }
}

resource "kubernetes_manifest" "auth" {
  count = local.ext_token_auth_count

  manifest = {
    apiVersion = "configuration.konghq.com/v1"
    kind       = "KongPlugin"
    metadata = {
      name      = local.ext_token_auth_available_name
      namespace = var.namespace
    }

    plugin = "external-auth"

    config = {
      auth_endpoint = "${var.ext_token_auth_url}"
    }
  }
}

resource "kubernetes_manifest" "redirect" {
  count = local.redirect_count
  manifest = {
    "apiVersion" = "configuration.konghq.com/v1"
    "kind"       = "KongPlugin"
    "metadata" = {
      "name"      = local.redirect_available_name
      "namespace" = var.namespace
    }
    "config" = {
      "access"        = [templatefile("${path.module}/scripts/req_301_redirect.lua", {
        location = var.redirect_location
      })]
    }
    "plugin" = "pre-function"
  }
}
