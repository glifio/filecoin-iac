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
      "lifecycle"     = var.is_spot_instance ? "spot" : "ondemand"
      "nodeGroupName" = local.get_nodegroup_postfix
      "environment"   = local.get_environment
      "is_allow_all_nodes" = var.is_allow_all_nodes == false ? "specific_nodes" : "allow_all_nodes"
    }
  )


}
