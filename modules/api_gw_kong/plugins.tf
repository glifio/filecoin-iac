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

resource "kubernetes_manifest" "request_transformer-statecirculatingsupply" {
  manifest = {
    "apiVersion" = "configuration.konghq.com/v1"
    "kind"       = "KongPlugin"
    "metadata" = {
      "name"      = "${local.prefix}-request-transformer-statecirculatingsupply"
      "namespace" = var.namespace
    }
    "config" = {
      "http_method" = "POST"
      "add" = {
        "headers" = [
          "Content-Type:application/json"
        ]
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
      "name"      = "${local.prefix}-request-transformer-content-type"
      "namespace" = var.namespace
    }
    "config" = {
      "http_method" = "POST"
      "add" = {
        "headers" = [
          "Content-Type:application/json"
        ]
      }
    }
    "plugin" = "response-transformer"
  }
}

resource "kubernetes_manifest" "request_transformer-vmcirculatingsupply" {
  manifest = {
    "apiVersion" = "configuration.konghq.com/v1"
    "kind"       = "KongPlugin"
    "metadata" = {
      "name"      = "${local.prefix}-request-transformer-vmcirculatingsupply"
      "namespace" = var.namespace
    }
    "config" = {
      "http_method" = "POST"
      "add" = {
        "headers" = [
          "Content-Type:application/json"
        ]
        "body" = [
          "jsonrpc:2.0",
          "method:Filecoin.StateVMCirculatingSupplyInternal",
          "id:42",
          "params:[[]]"
        ]
      }
    }
    "plugin" = "request-transformer"
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
      "name"      = "${local.prefix}-request-transformer-to-rpcv0"
      "namespace" = var.namespace
    }
    "config" = {
      "add" = {
        "headers" = [
          "Authorization: Bearer ${local.auth_token}"
        ]
      }
    }
    "plugin" = "request-transformer"
  }
}
