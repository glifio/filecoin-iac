data "aws_caller_identity" "current" {}
data "aws_availability_zones" "main" {
  state = "available"
}

data "tls_certificate" "this" {
  url = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

data "aws_secretsmanager_secret_version" "opensearch_user_credentials" {
  secret_id = aws_secretsmanager_secret.opensearch_user_credentials.id
}

data "aws_route53_zone" "selected" {
  name         = var.route53_domain
  private_zone = false
}

data "aws_ebs_snapshot" "fvm_archive_1" {
  count = local.is_prod_envs

  most_recent = true

  filter {
    name   = "tag:Tenant"
    values = ["fvm-archive"]
  }

  filter {
    name   = "tag:PartNumber"
    values = [1]
  }
}

data "aws_ebs_snapshot" "fvm_archive_2" {
  count = local.is_prod_envs

  most_recent = true

  filter {
    name   = "tag:Tenant"
    values = ["fvm-archive"]
  }

  filter {
    name   = "tag:PartNumber"
    values = [2]
  }
}

data "aws_ebs_snapshot" "fvm_archive_3" {
  count = local.is_prod_envs

  most_recent = true

  filter {
    name   = "tag:Tenant"
    values = ["fvm-archive"]
  }

  filter {
    name   = "tag:PartNumber"
    values = [3]
  }
}

data "aws_ebs_snapshot" "fvm_archive_4" {
  count = local.is_prod_envs

  most_recent = true

  filter {
    name   = "tag:Tenant"
    values = ["fvm-archive"]
  }

  filter {
    name   = "tag:PartNumber"
    values = [4]
  }
}

data "aws_secretsmanager_secret_version" "budget_alarm_slack" {
  count     = local.is_prod_envs
  secret_id = aws_secretsmanager_secret.budget_alarm_slack[0].id
}
