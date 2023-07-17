locals {
  project = var.global_config["project"]
  region  = var.global_config["region"]
  env     = var.global_config["environment"]
  subenv  = var.global_config["sub_environment"]

  cluster_name = var.nodegroup_config["cluster_name"]
  vpc_id       = var.nodegroup_config["vpc_id"]
  cidr_block   = var.nodegroup_config["cidr_blocks"]
  subnet_ids   = var.nodegroup_config["subnet_ids"]

  subnet_id = local.subnet_ids[0]
  # The idea is joining a region with AZ symbol as a,b etc. Finally I should get smth like us-east-2a.
  nodegroup_az = join("", [local.region, var.az_postfix])

  nodegroup_name             = var.name != null ? var.name : random_string.nodegroup_name_postfix.result
  nodegroup_name_capacitated = var.is_spot_instance ? "${local.nodegroup_name}-spot" : "${local.nodegroup_name}-ondemand"

  launch_template         = var.is_spot_instance ? aws_launch_template.lt_spot[0].id : aws_launch_template.lt_ondemand[0].id
  launch_template_version = var.is_spot_instance ? aws_launch_template.lt_spot[0].latest_version : aws_launch_template.lt_ondemand[0].latest_version

  # the logic which uses for making labels inside k8s nodes
  kubetnetes_labels = merge(
    {
      "lifecycle"                  = var.is_spot_instance ? "spot" : "ondemand"
      "nodeGroupName"              = local.nodegroup_name
      "environment"                = local.env
      "assign_to_space00_07_nodes" = var.is_critical == true ? "allow_only_critical_pods" : "allow_any_pods"
    },
    var.custom_labels
  )
}
