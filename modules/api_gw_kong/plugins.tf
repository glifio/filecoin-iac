resource "kubernetes_manifest" "request_transformer-to_rpc_v0" {
  manifest = {
    "apiVersion" = "configuration.konghq.com/v1"
    "kind"       = "KongPlugin"
    "metadata" = {
      "name"      = "${local.prefix}-request-transformer-to-rpc-v0"
      "namespace" = var.namespace
    }
    "config" = {
      "replace" = {
        "uri" = local.paths.rpc_v0
      }
    }
    "plugin" = "request-transformer"
  }
}

resource "kubernetes_manifest" "request_transformer-to_rpc_v1" {
  manifest = {
    "apiVersion" = "configuration.konghq.com/v1"
    "kind"       = "KongPlugin"
    "metadata" = {
      "name"      = "${local.prefix}-request-transformer-to-rpc-v1"
      "namespace" = var.namespace
    }
    "config" = {
      "replace" = {
        "uri" = local.paths.rpc_v1
      }
    }
    "plugin" = "request-transformer"
  }
}

resource "kubernetes_manifest" "request_transformer-to_diluted_supply" {
  manifest = {
    "apiVersion" = "configuration.konghq.com/v1"
    "kind"       = "KongPlugin"
    "metadata" = {
      "name"      = "${local.prefix}-request-transformer-to-dilutedsupply"
      "namespace" = var.namespace
    }
    "config" = {
      "replace" = {
        "uri" = local.paths.diluted_supply
      }
    }
    "plugin" = "request-transformer"
  }
}

resource "kubernetes_manifest" "request_transformer-to_root" {
  manifest = {
    "apiVersion" = "configuration.konghq.com/v1"
    "kind"       = "KongPlugin"
    "metadata" = {
      "name"      = "${local.prefix}-request-transformer-to-root"
      "namespace" = var.namespace
    }
    "config" = {
      "replace" = {
        "uri" = "/"
      }
    }
    "plugin" = "request-transformer"
  }
}


resource "kubernetes_manifest" "request_transformer-to_index" {
  manifest = {
    "apiVersion" = "configuration.konghq.com/v1"
    "kind"       = "KongPlugin"
    "metadata" = {
      "name"      = "${local.prefix}-request-transformer-to-index"
      "namespace" = var.namespace
    }
    "config" = {
      "replace" = {
        "uri" = local.paths.index
      }
    }
    "plugin" = "request-transformer"
  }
}

resource "kubernetes_manifest" "response_transformer-content_type" {
  manifest = {
    "apiVersion" = "configuration.konghq.com/v1"
    "kind"       = "KongPlugin"
    "metadata" = {
      "name"      = "${local.prefix}-response-transformer-content-type"
      "namespace" = var.namespace
    }
    "config" = {
      "add" = {
        "headers" = [
          "Content-Type:application/json"
        ]
      }
      "replace" = {
        "headers" = [
          "Content-Type:application/json"
        ]
      }
    }
    "plugin" = "response-transformer"
  }
}


resource "kubernetes_manifest" "serverless_function-statecirculatingsupply" {
  manifest = {
    "apiVersion" = "configuration.konghq.com/v1"
    "kind"       = "KongPlugin"
    "metadata" = {
      "name"      = "${local.prefix}-serverless-function-statecirculatingsupply"
      "namespace" = var.namespace
    }
    "config" = {
      "access"        = [file("${path.module}/scripts/req_statecirculatingsupply.lua")]
      "body_filter"   = [file("${path.module}/scripts/res_statecirculatingsupply.lua")]
      "header_filter" = [file("${path.module}/scripts/clear_content-length.lua")]
    }
    "plugin" = "post-function"
  }
}

resource "kubernetes_manifest" "serverless_function-vmcirculatingsupply" {
  manifest = {
    "apiVersion" = "configuration.konghq.com/v1"
    "kind"       = "KongPlugin"
    "metadata" = {
      "name"      = "${local.prefix}-serverless-function-vmcirculatingsupply"
      "namespace" = var.namespace
    }
    "config" = {
      "access"        = [file("${path.module}/scripts/req_vmcirculatingsupply.lua")]
      "body_filter"   = [file("${path.module}/scripts/res_vmcirculatingsupply.lua")]
      "header_filter" = [file("${path.module}/scripts/clear_content-length.lua")]
    }
    "plugin" = "post-function"
  }
}

resource "kubernetes_manifest" "request_transformer-public_access" {
  manifest = {
    "apiVersion" = "configuration.konghq.com/v1"
    "kind"       = "KongPlugin"
    "metadata" = {
      "name"      = "${local.prefix}-request-transformer-public-access"
      "namespace" = var.namespace
    }
    "config" = {
      "add" = {
        "headers" = [
          "Authorization: Bearer ${local.auth_token}"
        ]
      }
      "replace" = {
        "headers" = [
          "Authorization: Bearer ${local.auth_token}"
        ]
      }
    }
    "plugin" = "request-transformer"
  }
}

resource "kubernetes_manifest" "request_transformer-daemon_access" {
  manifest = {
    "apiVersion" = "configuration.konghq.com/v1"
    "kind"       = "KongPlugin"
    "metadata" = {
      "name"      = "${local.prefix}-request-transformer-daemon-access"
      "namespace" = var.namespace
    }
    "config" = {
      "add" = {
        "headers" = [
          "Authorization: Bearer ${local.daemon_token}"
        ]
      }
      "replace" = {
        "headers" = [
          "Authorization: Bearer ${local.daemon_token}"
        ]
      }
    }
    "plugin" = "request-transformer"
  }
}

resource "kubernetes_manifest" "cors" {
  manifest = {
    "apiVersion" = "configuration.konghq.com/v1"
    "kind"       = "KongPlugin"
    "metadata" = {
      "name"      = "${local.prefix}-cors"
      "namespace" = var.namespace
    }
    "config" = {
      "origins" = [
        "*"
      ]
      "headers" = [
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
    "plugin" = "cors"
  }
}