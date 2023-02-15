locals {
  get_project         = lookup(var.get_global_configuration, "project", "")
  get_region          = lookup(var.get_global_configuration, "region", "")
  get_environment     = lookup(var.get_global_configuration, "environment", "")
  get_sub_environment = lookup(var.get_global_configuration, "sub_environment", "")

  get_request_transformer = var.is_kong_auth_header_enabled && var.is_kong_transformer_header_enabled ? local.auth_header_replace_url : local.replace_url_only
  auth_header_replace_url = var.is_kong_auth_header_enabled && var.is_kong_transformer_header_enabled ? kubernetes_manifest.request_transformer_auth_header_replace_url[0].manifest.metadata.name : local.replace_url_only
  replace_url_only        = var.is_kong_transformer_header_enabled && var.is_kong_auth_header_enabled == false ? kubernetes_manifest.request_transformer_replace_url_only.0.manifest.metadata.name : ""

  get_cors              = var.is_kong_cors_enabled ? kubernetes_manifest.cors[0].manifest.metadata.name : ""
  get_whitelist_ips     = var.enable_whitelist_ip ? kubernetes_manifest.ip_restriction[0].manifest.metadata.name : ""
  get_methods_blacklist = var.enable_methods_blacklist ? kubernetes_manifest.serverless_function-methods_blacklist[0].manifest.metadata.name : ""
  get_kong_list_plugins = local.get_cors == null && local.get_request_transformer == null ? "" : join(", ", compact([local.get_cors, local.get_whitelist_ips, local.get_request_transformer, local.get_methods_blacklist]))

  validate_whitelist_ips   = var.enable_whitelist_ip ? 1 : 0
  enable_methods_blacklist = var.enable_methods_blacklist ? 1 : 0
}
