resource "aws_vpc" "main" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    {
      "Name" = "${module.generator.prefix}-vpc"
    },
    module.generator.common_tags
  )
}

resource "aws_vpc_dhcp_options" "main" {
  domain_name         = "${module.generator.prefix}.aws.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = merge(
    {
      "Name" = "${module.generator.prefix}-dhcp-options"
    },
    module.generator.common_tags
  )
}

resource "aws_vpc_dhcp_options_association" "deployment" {
  vpc_id          = aws_vpc.main.id
  dhcp_options_id = aws_vpc_dhcp_options.main.id
}
