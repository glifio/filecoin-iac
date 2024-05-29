resource "aws_launch_template" "lt_ondemand" {
  count                   = var.is_spot_instance ? 0 : 1
  name                    = "${module.generator.prefix}-${local.nodegroup_name}-ondemand"
  disable_api_termination = false
  ebs_optimized           = true
  key_name                = aws_key_pair.eks_node.key_name
  user_data = (
    var.use_existing_ebs
    ? base64encode(templatefile("${path.module}/bootstrap/early-customizations/ebs-external.sh", { tpl_tenant = var.ebs_tenant }))
    : filebase64("${path.module}/bootstrap/early-customizations/${var.user_data}")
  )

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size           = var.root_volume_size
      volume_type           = "gp3"
      throughput            = "125"
      delete_on_termination = true
      encrypted             = false
      iops                  = 3000
    }
  }

  # we need to specify AZ, basause we have statefulsets and VPC.
  placement {
    availability_zone = local.nodegroup_az
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
    http_protocol_ipv6          = "disabled"
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      {
        "Name"          = "${module.generator.prefix}-${local.nodegroup_name}-ondemand",
        "Type"          = "ondemand"
        "nodeGroupName" = local.nodegroup_name
      },
      module.generator.common_tags
    )
  }

  tag_specifications {
    resource_type = "volume"

    tags = merge(
      {
        "Name"          = "${module.generator.prefix}-${local.nodegroup_name}-ondemand",
        "nodeGroupName" = local.nodegroup_name,
        "Type"          = "ondemand"
      },
      module.generator.common_tags
    )
  }


  tags = merge(
    {
      "Name"          = "${module.generator.prefix}-${local.nodegroup_name}-ondemand-lt",
      "nodeGroupName" = local.nodegroup_name,
      "Type"          = "ondemand"
    },
    module.generator.common_tags
  )
}
