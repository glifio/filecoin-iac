######## START BLOCK request_transformer PLUGIN ############
##
## Description:
## The logic depends on a configuration that we want to apply.
## If we want only JTW or REPLACE_URL or BOTH or NOTHING we need to
## provide bool value from the init module conponent.

resource "kubernetes_manifest" "request_transformer_auth_header_replace_url" {
  count = var.is_kong_auth_header_enabled && var.is_kong_transformer_header_enabled ? 1 : 0
  manifest = {
    "apiVersion" = "configuration.konghq.com/v1"
    "kind"       = "KongPlugin"
    "metadata" = {
      "name"      = "request-transformer-header-${random_string.rand.result}"
      "namespace" = var.get_ingress_namespace
    }
    "config" = {
      "add" = {
        "headers" = [
          var.is_kong_auth_header_block_public_access ? "Authorization: false" : "Authorization: Bearer ${lookup(jsondecode(data.aws_secretsmanager_secret_version.current[0].secret_string), "jwt_token_kong_rw", null)}"
        ]
      }
      "replace" = {
        "headers" = [
          var.is_kong_auth_header_block_public_access ? "Authorization: false" : "Authorization: Bearer ${lookup(jsondecode(data.aws_secretsmanager_secret_version.current[0].secret_string), "jwt_token_kong_rw", null)}"
        ]
        "uri" = var.kong_plugin_replace_url
      }
    }
    "plugin" = "request-transformer"
  }
}


resource "kubernetes_manifest" "request_transformer_replace_url_only" {
  count = var.is_kong_transformer_header_enabled && var.is_kong_auth_header_enabled == false ? 1 : 0
  manifest = {
    "apiVersion" = "configuration.konghq.com/v1"
    "kind"       = "KongPlugin"
    "metadata" = {
      "name"      = "request-transformer-header-${random_string.rand.result}"
      "namespace" = var.get_ingress_namespace
    }
    "config" = {
      "replace" = {
        "uri" = var.kong_plugin_replace_url
      }
    }
    "plugin" = "request-transformer"
  }
}


######## END BLOCK request_transformer PLUGIN ############


# CORS kong plugin documentation: https://docs.konghq.com/hub/kong-inc/cors/
resource "kubernetes_manifest" "cors" {
  count = var.is_kong_cors_enabled ? 1 : 0
  manifest = {
    "apiVersion" = "configuration.konghq.com/v1"
    "kind"       = "KongPlugin"
    "metadata" = {
      "name"      = "cors-test-${random_string.rand.result}"
      "namespace" = var.get_ingress_namespace
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


######## START BLOCK ip-restriction PLUGIN ############

resource "kubernetes_manifest" "ip_restriction" {
  count = local.validate_whitelist_ips
  manifest = {
    "apiVersion" = "configuration.konghq.com/v1"
    "kind"       = "KongPlugin"
    "metadata" = {
      "name"      = "ip-whitelist-${random_string.rand.result}"
      "namespace" = var.get_ingress_namespace
    }
    "config" = {
      "allow" = var.get_whitelist_ips
    }
    "plugin" = "ip-restriction"
  }
}

######## END BLOCK ip-restriction PLUGIN ############

resource "kubernetes_manifest" "response_transformer-content_type" {
  count = local.create_return_json_plugin

  manifest = {
    "apiVersion" = "configuration.konghq.com/v1"
    "kind"       = "KongPlugin"
    "metadata" = {
      "name"      = "response-transformer-content-type-${random_string.rand.result}"
      "namespace" = var.get_ingress_namespace
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
