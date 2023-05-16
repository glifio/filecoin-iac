resource "kubernetes_manifest" "request_transformer-public_access" {
  count = local.public_access_count

  manifest = {
	apiVersion = "configuration.konghq.com/v1"
	kind       = "KongPlugin"
	metadata = {
	  name      = "${var.get_nodegroup_name}-public-access"
	  namespace = var.get_namespace
	}

	plugin = "request-transformer"

	config = {
	  add = {
		headers = [
		  var.enable_public_access ? "Authorization: false" : "Authorization: Bearer ${local.auth_token}"
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
	  name      = "${var.get_nodegroup_name}-path-transformer"
	  namespace = var.get_namespace
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
	  name      = "${var.get_nodegroup_name}-combined-transformer"
	  namespace = var.get_namespace
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

resource "kubernetes_manifest" "request_transformer-switched" {
  count = local.switched_transformer_count

  manifest = {
	apiVersion = "configuration.konghq.com/v1"
	kind       = "KongPlugin"
	metadata   = {
	  name      = "${var.get_nodegroup_name}-switched-transformer"
	  namespace = var.get_namespace
	}

	plugin = "request-transformer"

	config = {
	  add = {
		headers = [
		  "Authorization: Bearer ${local.switch_to_token}"
		]
	  }

	  replace = {
		headers = [
		  "Authorization: Bearer ${local.switch_to_token}"
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
	  name      = "${var.get_nodegroup_name}-cors"
	  namespace = var.get_namespace
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
	  name      = "${var.get_nodegroup_name}-return-json"
	  namespace = var.get_namespace
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