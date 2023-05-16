locals {
  path_transformer_condition = var.enable_path_transformer && !var.enable_public_access
  path_transformer_count     = local.path_transformer_condition ? 1 : 0
  path_transformer_name      = local.path_transformer_condition ? kubernetes_manifest.request_transformer-path_transformer[0].manifest.metadata.name : ""

  public_access_condition = !var.enable_path_transformer && var.enable_public_access
  public_access_count     = local.public_access_condition ? 1 : 0
  public_access_name      = local.public_access_condition ? kubernetes_manifest.request_transformer-public_access[0].manifest.metadata.name : ""

  combined_transformer_condition = var.enable_path_transformer && var.enable_public_access
  combined_transformer_count     = local.combined_transformer_condition ? 1 : 0
  combined_transformer_name      = local.combined_transformer_condition ? kubernetes_manifest.request_transformer-combined_transformer[0].manifest.metadata.name : ""

  cors_count = var.enable_cors ? 1 : 0
  cors_name  = var.enable_cors ? kubernetes_manifest.cors[0].manifest.metadata.name : ""

  return_json_count = var.enable_return_json ? 1 : 0
  return_json_name  = var.enable_return_json ? kubernetes_manifest.response_transformer-return_json[0].manifest.metadata.name : ""

  available_plugins = [
    local.public_access_name,
    local.path_transformer_name,
    local.combined_transformer_name,
    local.cors_name,
    local.return_json_name,
  ]

  enabled_plugins = compact(local.available_plugins)
  plugins_string  = join(", ", local.enabled_plugins)

  auth_token = var.enable_public_access ? jsondecode(data.aws_secretsmanager_secret_version.default[0].secret_string)[var.auth_token_attribute] : ""
}
