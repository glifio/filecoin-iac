locals {
  # Create request transformer that transforms the path
  path_transformer_condition      = var.enable_path_transformer && !var.enable_access_control
  path_transformer_count          = local.path_transformer_condition ? 1 : 0
  path_transformer_available_name = "${var.name}-path-transformer"
  path_transformer_enabled_name   = !local.path_transformer_condition ? "" : local.path_transformer_available_name

  # Create request transformer that adds Authorization header with a valid JWT token
  public_access_add_condition      = !var.enable_path_transformer && var.enable_access_control && var.access_control_public && !var.access_control_replace
  public_access_add_count          = local.public_access_add_condition ? 1 : 0
  public_access_add_available_name = "${var.name}-public-access-add"
  public_access_add_enabled_name   = !local.public_access_add_condition ? "" : local.public_access_add_available_name

  # Create request transformer that adds or replaces Authorization header with a valid JWT token
  public_access_replace_condition      = !var.enable_path_transformer && var.enable_access_control && var.access_control_public && var.access_control_replace
  public_access_replace_count          = local.public_access_replace_condition ? 1 : 0
  public_access_replace_available_name = "${var.name}-public-access-replace"
  public_access_replace_enabled_name   = !local.public_access_replace_condition ? "" : local.public_access_replace_available_name

  # Create request transformer that adds Authorization header with an ivalid JWT token
  private_access_add_condition      = !var.enable_path_transformer && var.enable_access_control && !var.access_control_public && !var.access_control_replace
  private_access_add_count          = local.private_access_add_condition ? 1 : 0
  private_access_add_available_name = "${var.name}-private-access-add"
  private_access_add_enabled_name   = !local.private_access_add_condition ? "" : local.private_access_add_available_name

  # Create request transformer that adds or replaces Authorization header with an ivalid JWT token
  private_access_replace_condition      = !var.enable_path_transformer && var.enable_access_control && !var.access_control_public && var.access_control_replace
  private_access_replace_count          = local.private_access_replace_condition ? 1 : 0
  private_access_replace_available_name = "${var.name}-private-access-replace"
  private_access_replace_enabled_name   = !local.private_access_replace_condition ? "" : local.private_access_replace_available_name

  # Create request transformer that adds Authorization header with a valid JWT token and transforms the path
  path_transformer_public_access_add_condition      = var.enable_path_transformer && var.enable_access_control && var.access_control_public && !var.access_control_replace
  path_transformer_public_access_add_count          = local.path_transformer_public_access_add_condition ? 1 : 0
  path_transformer_public_access_add_available_name = "${var.name}-path-transformer-public-access-add"
  path_transformer_public_access_add_enabled_name   = !local.path_transformer_public_access_add_condition ? "" : local.path_transformer_public_access_add_available_name

  # Create request transformer that adds or replaces Authorization header with a valid JWT token and transforms the path
  path_transformer_public_access_replace_condition      = var.enable_path_transformer && var.enable_access_control && var.access_control_public && var.access_control_replace
  path_transformer_public_access_replace_count          = local.path_transformer_public_access_replace_condition ? 1 : 0
  path_transformer_public_access_replace_available_name = "${var.name}-path-transformer-public-access-replace"
  path_transformer_public_access_replace_enabled_name   = !local.path_transformer_public_access_replace_condition ? "" : local.path_transformer_public_access_replace_available_name

  # Create request transformer that adds Authorization header with an ivalid JWT token and transforms the path
  path_transformer_private_access_add_condition      = var.enable_path_transformer && var.enable_access_control && !var.access_control_public && !var.access_control_replace
  path_transformer_private_access_add_count          = local.path_transformer_private_access_add_condition ? 1 : 0
  path_transformer_private_access_add_available_name = "${var.name}-path-transformer-private-access-add"
  path_transformer_private_access_add_enabled_name   = !local.path_transformer_private_access_add_condition ? "" : local.path_transformer_private_access_add_available_name

  # Create request transformer that adds or replaces Authorization header with an ivalid JWT token and transforms the path
  path_transformer_private_access_replace_condition      = var.enable_path_transformer && var.enable_access_control && !var.access_control_public && var.access_control_replace
  path_transformer_private_access_replace_count          = local.path_transformer_private_access_replace_condition ? 1 : 0
  path_transformer_private_access_replace_available_name = "${var.name}-path-transformer-private-access-replace"
  path_transformer_private_access_replace_enabled_name   = !local.path_transformer_private_access_replace_condition ? "" : local.path_transformer_private_access_replace_available_name

  cors_count          = var.enable_cors ? 1 : 0
  cors_available_name = "${var.name}-cors"
  cors_enabled_name   = !var.enable_cors ? "" : local.cors_available_name

  return_json_count          = var.enable_return_json ? 1 : 0
  return_json_available_name = "${var.name}-return-json"
  return_json_enabled_name   = !var.enable_return_json ? "" : local.return_json_available_name

  available_plugins = [
    local.path_transformer_enabled_name,
    local.public_access_add_enabled_name,
    local.public_access_replace_enabled_name,
    local.private_access_add_enabled_name,
    local.private_access_replace_enabled_name,
    local.path_transformer_public_access_add_enabled_name,
    local.path_transformer_public_access_replace_enabled_name,
    local.path_transformer_private_access_add_enabled_name,
    local.path_transformer_private_access_replace_enabled_name,
    local.cors_enabled_name,
    local.return_json_enabled_name
  ]

  enabled_plugins = compact(local.available_plugins)
  plugins_string  = join(", ", local.enabled_plugins)

  limit_reqs_wo_header_count          = var.enable_limit_reqs_wo_header ? 1 : 0
  limit_reqs_wo_header_available_name = "${var.name}-limit-reqs-wo-header"
  limit_reqs_wo_header_enabled_name   = !var.enable_limit_reqs_wo_header ? "" : local.limit_reqs_wo_header_available_name

  enabled_limit_reqs_wo_header_plugins = compact(concat(local.available_plugins, [local.limit_reqs_wo_header_enabled_name]))
  limit_reqs_wo_header_plugins_string  = join(", ", local.enabled_limit_reqs_wo_header_plugins)

  ext_token_auth_count          = var.enable_ext_token_auth ? 1 : 0
  ext_token_auth_available_name = "${var.name}-ext-token-auth"
  ext_token_auth_enabled_name   = !var.enable_ext_token_auth ? "" : local.ext_token_auth_available_name

  enabled_ext_token_auth_plugins = compact(concat(local.available_plugins, [local.ext_token_auth_enabled_name]))
  ext_token_auth_plugins_string  = join(", ", local.enabled_ext_token_auth_plugins)

  auth_token = var.enable_access_control && var.access_control_public ? jsondecode(data.aws_secretsmanager_secret_version.default[0].secret_string)[var.auth_token_attribute] : ""
}
