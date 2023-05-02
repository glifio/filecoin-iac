locals {
  get_project         = lookup(var.get_global_configuration, "project", "")
  get_region          = lookup(var.get_global_configuration, "region", "")
  get_environment     = lookup(var.get_global_configuration, "environment", "")
  get_sub_environment = lookup(var.get_global_configuration, "sub_environment", "")

  get_cluster_name   = lookup(var.get_eks_nodegroups_global_configuration, "cluster_name", "")
  get_vpc_id         = lookup(var.get_eks_nodegroups_global_configuration, "vpc_id", "")
  get_vpc_cidr_block = lookup(var.get_eks_nodegroups_global_configuration, "cidr_blocks", "")
  get_subnet_ids     = lookup(var.get_eks_nodegroups_global_configuration, "subnet_ids", "")

  get_subnet_id     = local.get_subnet_ids[2]
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

  create_secret = var.create_new_secret ? 1 : 0

# use exist secrets f.e api-read-dev

  private_key         =  lookup(jsondecode(var.exist_secret[0].secret_string), "private_key", null)
  jwt_token           =  lookup(jsondecode(var.exist_secret[0].secret_string), "jwt_token", null)
  jwt_token_kong_rw   =  lookup(jsondecode(var.exist_secret[0].secret_string), "jwt_token_kong_rw", null)

  secret_string = { "private_key" : "${local.private_key}", "jwt_token" : "${local.jwt_token}", "jwt_token_kong_rw" : "${local.jwt_token_kong_rw}"}

  # create new secret

  new_private_key         =  lookup(jsondecode(aws_secretsmanager_secret_version.main.secret_string), "private_key", null)
  new_jwt_token           =  lookup(jsondecode(aws_secretsmanager_secret_version.main.secret_string), "jwt_token", null)

  new_secret_string = { "private_key" : "${local.new_private_key}", "jwt_token" : "${local.new_jwt_token}"}

}
