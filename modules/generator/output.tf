# map regions to short codes to minimize resource names
locals {
  regionsMap = {
    us-east-2      = "use1"
    ap-northeast-1 = "apn1"
  }
}

output "region_short" {
  value = local.regionsMap[var.region]
}

output "prefix" {
  value = "${var.project}-${var.environment}-${local.regionsMap[var.region]}-${var.sub_environment}"
}

output "prefix_region" {
  value = "${var.project}-${var.environment}-${local.regionsMap[var.region]}"
}

output "prefix_account" {
  value = "${var.project}-${var.environment}"
}

output "common_tags" {
  value = {
    Project         = "Filecoin"
    Environment     = var.environment
    Sub_environment = var.sub_environment
    ProvisionedWith = "Terraform"
  }
}

output "uid" {
  value = random_string.uid.result
}
