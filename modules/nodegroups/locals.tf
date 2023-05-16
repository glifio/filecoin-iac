locals {
  get_project         = lookup(var.get_global_configuration, "project", "")
  get_region          = lookup(var.get_global_configuration, "region", "")
  get_environment     = lookup(var.get_global_configuration, "environment", "")
  get_sub_environment = lookup(var.get_global_configuration, "sub_environment", "")

  get_cluster_name   = lookup(var.get_eks_nodegroups_global_configuration, "cluster_name", "")
  get_vpc_id         = lookup(var.get_eks_nodegroups_global_configuration, "vpc_id", "")
  get_vpc_cidr_block = lookup(var.get_eks_nodegroups_global_configuration, "cidr_blocks", "")
  get_subnet_ids     = lookup(var.get_eks_nodegroups_global_configuration, "subnet_ids", "")

  get_subnet_id = local.get_subnet_ids[2]
  #The idea is joingin a region with AZ symbol as a,b etc. Finally I should get smth like us-east-2a.
  make_az_nodegroup = join("", [local.get_region, var.availability_zone_postfix])

  get_nodegroup_postfix             = var.get_nodegroup_name == null ? random_string.nodegroup_name_postfix.result : var.get_nodegroup_name
  join_nodegrpup_name_capacity_type = var.is_spot_instance ? "${local.get_nodegroup_postfix}-spot" : "${local.get_nodegroup_postfix}-ondemand"
  get_launch_template               = var.is_spot_instance ? aws_launch_template.lt_spot[0].id : aws_launch_template.lt_ondemand[0].id
  get_launch_template_version       = var.is_spot_instance ? aws_launch_template.lt_spot[0].latest_version : aws_launch_template.lt_ondemand[0].latest_version

  # the logic which uses for making labels inside k8s nodes
  make_custom_k8s_labels = merge(
    {
      "lifecycle"                  = var.is_spot_instance ? "spot" : "ondemand"
      "nodeGroupName"              = local.get_nodegroup_postfix
      "environment"                = local.get_environment
      "assign_to_space00_07_nodes" = var.assign_to_space00_07_nodes == true ? "allow_only_critical_pods" : "allow_any_pods"
    }
  )

  # use exist secrets f.e api-read-dev

  private_key       = var.exist_secret != null ? lookup(jsondecode(var.exist_secret[0].secret_string), "private_key", null) : data.external.secret_generator.result.private_key
  jwt_token         = var.exist_secret != null ? lookup(jsondecode(var.exist_secret[0].secret_string), "jwt_token", null) : data.external.secret_generator.result.jwt_token
  jwt_token_kong_rw = var.exist_secret != null ? lookup(jsondecode(var.exist_secret[0].secret_string), "jwt_token_kong_rw", null) : data.external.secret_generator.result.jwt_token_kong_rw

  secret_string = { "private_key" : "${local.private_key}", "jwt_token" : "${local.jwt_token}", "jwt_token_kong_rw" : "${local.jwt_token_kong_rw}" }


  ### kong locals ###

    path_transformer_condition = var.enable_path_transformer && !var.enable_public_access
    path_transformer_count     = local.path_transformer_condition ? 1 : 0
    path_transformer_name      = local.path_transformer_condition ? kubernetes_manifest.request_transformer-path_transformer[0].manifest.metadata.name : ""

    public_access_condition = !var.enable_path_transformer && var.enable_public_access
    public_access_count     = local.public_access_condition ? 1 : 0
    public_access_name      = local.public_access_condition ? kubernetes_manifest.request_transformer-public_access[0].manifest.metadata.name : ""

    combined_transformer_condition = var.enable_path_transformer && var.enable_public_access
    combined_transformer_count     = local.combined_transformer_condition ? 1 : 0
    combined_transformer_name      = local.combined_transformer_condition ? kubernetes_manifest.request_transformer-combined_transformer[0].manifest.metadata.name : ""

    switched_transformer_condition   = !var.enable_public_access && !var.enable_path_transformer
    switched_transformer_count       = local.switched_transformer_condition ? 1 : 0
    switched_transformer_name        = local.switched_transformer_condition ? kubernetes_manifest.request_transformer-switched[0].manifest.metadata.name : ""

    cors_count = var.enable_cors ? 1 : 0
    cors_name  = var.enable_cors ? kubernetes_manifest.cors[0].manifest.metadata.name : ""

    return_json_count = var.enable_return_json ? 1 : 0
    return_json_name  = var.enable_return_json ? kubernetes_manifest.response_transformer-return_json[0].manifest.metadata.name : ""

    available_plugins = [
      local.public_access_name,
      local.path_transformer_name,
      local.combined_transformer_name,
      local.switched_transformer_name,
      local.cors_name,
      local.return_json_name,
    ]

    enabled_plugins = compact(local.available_plugins)
    plugins_string  = join(", ", local.enabled_plugins)


    auth_token = var.exist_secret != null ?  jsondecode(var.exist_secret[0].secret_string)[var.auth_token_attribute] : data.external.secret_generator.result.jwt_token_kong_rw
    switch_to_token = var.switch_to_token != null ? jsondecode(var.switch_to_token[0].secret_string)[var.auth_token_attribute] : local.auth_token

#  get_request_transformer = var.is_kong_auth_header_enabled && var.is_kong_transformer_header_enabled ? local.auth_header_replace_url : local.replace_url_only
#  auth_header_replace_url = var.is_kong_auth_header_enabled && var.is_kong_transformer_header_enabled ? kubernetes_manifest.request_transformer_auth_header_replace_url[0].manifest.metadata.name : local.replace_url_only
#  replace_url_only        = var.is_kong_transformer_header_enabled && var.is_kong_auth_header_enabled == false ? kubernetes_manifest.request_transformer_replace_url_only.0.manifest.metadata.name : ""
#
#  get_cors              = var.is_kong_cors_enabled ? kubernetes_manifest.cors[0].manifest.metadata.name : ""
#  get_whitelist_ips     = var.enable_whitelist_ip ? kubernetes_manifest.ip_restriction[0].manifest.metadata.name : ""
#  get_kong_list_plugins = local.get_cors == null && local.get_request_transformer == null ? "" : join(", ", compact([local.get_cors, local.get_whitelist_ips, local.get_request_transformer]))
#
#  validate_whitelist_ips = var.enable_whitelist_ip ? 1 : 0

#  use_jwt_token_kong_rw = var.switch_to_token == null ? "${lookup(jsondecode(data.aws_secretsmanager_secret_version.current[0].secret_string), "jwt_token_kong_rw", null)}" : "${lookup(jsondecode(var.switch_to_token[0].secret_string), "jwt_token_kong_rw", null)}"

}
