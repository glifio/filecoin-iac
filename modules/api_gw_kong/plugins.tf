resource "kubernetes_manifest" "request_transformer-to_rpc_v0" {
  manifest = {
    "apiVersion" = "configuration.konghq.com/v1"
    "kind"       = "KongPlugin"
    "metadata" = {
      "name" = "${locals.prefix}-request-transformer-to-rpc-v0"
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

resource "kubernetes_manifest" "request_transformer-to_diluted_supply" {
  manifest = {
    "apiVersion" = "configuration.konghq.com/v1"
    "kind"       = "KongPlugin"
    "metadata" = {
      "name" = "${locals.prefix}-request-transformer-to-dilutedsupply"
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
      "name" = "${locals.prefix}-request-transformer-to-root"
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
      "name" = "${locals.prefix}-request-transformer-to-index"
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

resource "kubernetes_manifest" "request_transformer-public_access" {
  manifest = {
    "apiVersion" = "configuration.konghq.com/v1"
    "kind"       = "KongPlugin"
    "metadata" = {
      "name" = "${locals.prefix}-request-transformer-to-rpcv0"
      "namespace" = var.namespace
    }
    "config" = {
      "add" = {
        "headers" = [
          # TODO: Replace with the secret value
          "Authorization: false"
        ]
      }
    }
    "plugin" = "request-transformer"
  }
}
