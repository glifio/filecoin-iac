locals {
  get_project         = lookup(var.get_global_configuration, "project", "")
  get_region          = lookup(var.get_global_configuration, "region", "")
  get_environment     = lookup(var.get_global_configuration, "environment", "")
  get_sub_environment = lookup(var.get_global_configuration, "sub_environment", "")

  replace_url_only        = var.is_kong_transformer_header_enabled && var.is_kong_auth_header_enabled == false ? kubernetes_manifest.request_transformer_replace_url_only.0.manifest.metadata.name : ""
  auth_header_replace_url = var.is_kong_auth_header_enabled && var.is_kong_transformer_header_enabled ? kubernetes_manifest.request_transformer_auth_header_replace_url[0].manifest.metadata.name : local.replace_url_only
  get_request_transformer = var.is_kong_auth_header_enabled && var.is_kong_transformer_header_enabled ? local.auth_header_replace_url : ""

  get_cors              = var.is_kong_cors_enabled ? kubernetes_manifest.cors[0].manifest.metadata.name : ""
  get_kong_list_plugins = local.get_cors == null && local.get_request_transformer == null ? "" : join(", ", compact([local.get_cors, local.get_request_transformer]))
}
