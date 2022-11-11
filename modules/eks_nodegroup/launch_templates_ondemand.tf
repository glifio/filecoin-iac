resource "aws_launch_template" "lt_ondemand" {
  count                   = var.is_spot_instance ? 0 : 1
  name                    = "${module.generator.prefix}-${local.get_nodegroup_postfix}-ondemand"
  disable_api_termination = false
  ebs_optimized           = true
  key_name                = aws_key_pair.eks_node.key_name
  user_data               = filebase64("${path.module}/bootstrap/early-customizations/nvme.sh")

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size           = 30
      volume_type           = "gp3"
      throughput            = "125"
      delete_on_termination = true
      encrypted             = false
      iops                  = 3000
    }
  }

  # we need to specify AZ, basause we have statefulsets and VPC.
  placement {
    availability_zone = local.make_az_nodegroup
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
        "Name"          = "${module.generator.prefix}-${local.get_nodegroup_postfix}-ondemand",
        "Type"          = "ondemand"
        "nodeGroupName" = local.get_nodegroup_postfix
        "assign_pods_to_key_nodes" = var.assign_pods_to_key_nodes
      },
      module.generator.common_tags
    )
  }

  tag_specifications {
    resource_type = "volume"

    tags = merge(
      {
        "Name"          = "${module.generator.prefix}-${local.get_nodegroup_postfix}-ondemand",
        "nodeGroupName" = local.get_nodegroup_postfix,
        "Type"          = "ondemand"
      },
      module.generator.common_tags
    )
  }


  tags = merge(
    {
      "Name"          = "${module.generator.prefix}-${local.get_nodegroup_postfix}-ondemand-lt",
      "nodeGroupName" = local.get_nodegroup_postfix,
      "Type"          = "ondemand"
    },
    module.generator.common_tags
  )
}
