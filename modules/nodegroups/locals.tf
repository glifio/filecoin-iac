locals {
  get_project         = lookup(var.get_global_configuration, "project", "")
  get_region          = lookup(var.get_global_configuration, "region", "")
  get_environment     = lookup(var.get_global_configuration, "environment", "")
  get_sub_environment = lookup(var.get_global_configuration, "sub_environment", "")

  get_cluster_name   = lookup(var.get_eks_nodegroups_global_configuration, "cluster_name", "")
  get_vpc_id         = lookup(var.get_eks_nodegroups_global_configuration, "vpc_id", "")
  get_vpc_cidr_block = lookup(var.get_eks_nodegroups_global_configuration, "cidr_blocks", "")
  get_subnet_ids     = lookup(var.get_eks_nodegroups_global_configuration, "subnet_ids", "")

  get_subnet_id = local.get_subnet_ids[0]
  #The idea is joingin a region with AZ symbol as a,b etc. Finally I should get smth like us-east-2a.
  make_az_nodegroup = join("", [local.get_region, var.availability_zone_postfix])

  get_nodegroup_postfix             = var.get_nodegroup_name == null ? random_string.nodegroup_name_postfix.result : var.get_nodegroup_name
  join_nodegrpup_name_capacity_type = var.is_spot_instance ? "${local.get_nodegroup_postfix}-spot" : "${local.get_nodegroup_postfix}-ondemand"
  get_launch_template               = var.is_spot_instance ? aws_launch_template.lt_spot[0].id : aws_launch_template.lt_ondemand[0].id
  get_launch_template_version       = var.is_spot_instance ? aws_launch_template.lt_spot[0].latest_version : aws_launch_template.lt_ondemand[0].latest_version

  # the logic which uses for making labels inside k8s nodes
  make_custom_k8s_labels = merge(
    {
      "lifecycle"              = var.is_spot_instance ? "spot" : "ondemand"
      "nodeGroupName"          = local.get_nodegroup_postfix
      "environment"            = local.get_environment
      "assign_to_archive_node" = var.assign_to_archive_node == true ? "allow_only_critical_pods" : "allow_any_pods"
    }
  )

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

  # secrets locals #

  aws_secret_count = var.create_aws_secret ? 1 : 0
  k8s_secret_count = var.create_k8s_secret ? 1 : 0

  aws_secret_name = "${module.generator.prefix}-${var.get_nodegroup_name}"
  k8s_secret_name = "${var.get_nodegroup_name}${var.k8s_secret_postfix}"


  from_secret_condition = length(var.from_secret) > 0
  from_secret_count     = local.from_secret_condition ? 1 : 0
  from_secret_name      = var.from_secret

  # If importing from another secret, get secret_string from there. Otherwise, generate a new one
  secret_string = local.from_secret_condition ? data.aws_secretsmanager_secret_version.from[0].secret_string : jsonencode(data.external.secret.result)

  auth_token = local.from_secret_condition ? jsondecode(data.aws_secretsmanager_secret_version.from[0].secret_string)[var.auth_token_attribute] : jsonencode(data.external.secret.result.jwt_token_kong_rw)
}
