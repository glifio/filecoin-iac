resource "aws_opensearch_domain" "main" {
  domain_name    = "${module.generator.prefix_region}-os"
  engine_version = "OpenSearch_1.3"

  access_policies = templatefile("${path.module}/templates/policies/opensearch_policy.pol.tpl", {
    aws_account_id = data.aws_caller_identity.current.account_id
    aws_region     = var.region
    os_domain_name = "${module.generator.prefix_region}-os"
  })

  auto_tune_options {
    desired_state = "ENABLED"
    #    maintenance_schedule {
    #      cron_expression_for_recurrence = ""
    #      start_at                       = ""
    #      duration {
    #        unit  = "1"
    #        value = 2
    #      }
    #    }
    rollback_on_disable = "NO_ROLLBACK"
  }

  node_to_node_encryption {
    enabled = true
  }

  domain_endpoint_options {
    custom_endpoint_enabled         = true
    custom_endpoint                 = "kibana.${var.route53_domain}"
    custom_endpoint_certificate_arn = aws_acm_certificate.opensearch_acm.arn
    enforce_https                   = true
    tls_security_policy             = "Policy-Min-TLS-1-2-2019-07"
  }

  encrypt_at_rest {
    enabled    = true
    kms_key_id = aws_kms_alias.s3_env_key_alias.target_key_id
  }

  advanced_security_options {
    enabled                        = true
    internal_user_database_enabled = true
    # TODO: we have to create a secret firstly, and,only after, we can create opensearch
    master_user_options {
      master_user_name     = (lookup(jsondecode(data.aws_secretsmanager_secret_version.opensearch_user_credentials.secret_string), "opensearch_username", null))
      master_user_password = (lookup(jsondecode(data.aws_secretsmanager_secret_version.opensearch_user_credentials.secret_string), "opensearch_password", null))
    }
  }

  cluster_config {
    instance_type  = "c6g.large.search"
    warm_enabled   = false
    instance_count = local.opensearch_instance_count

    #    zone_awareness_config {
    #      availability_zone_count = 2
    #    }
  }

  ebs_options {
    volume_type = "gp3"
    ebs_enabled = true
    volume_size = 256
    iops        = 3000
  }
  tags = module.generator.common_tags
}

resource "aws_route53_record" "opensearch" {
  zone_id         = data.aws_route53_zone.selected.zone_id
  name            = "kibana.${var.route53_domain}"
  allow_overwrite = true
  type            = "CNAME"
  ttl             = "60"
  records         = [aws_opensearch_domain.main.endpoint]
}

resource "aws_sns_topic" "opensearch_alerts" {
  name = "${module.generator.prefix}-opensearch-alerts"
}

resource "aws_sns_topic_subscription" "cid-checker-team" {
  topic_arn = aws_sns_topic.opensearch_alerts.arn
  protocol  = "email"
  endpoint  = "1658_filecoin_cid@protofire.io"
}

resource "aws_iam_role" "opensearch_alerts" {
  name        = "${module.generator.prefix}-opensearch-alerts"
  description = "${module.generator.prefix}-opensearch-alerts"

  assume_role_policy = file("${path.module}/templates/roles/opensearch_role.pol.tpl")

  tags = merge(
    {
      "Name" = "${module.generator.prefix}-opensearch-alerts"
    },
    module.generator.common_tags
  )
}

resource "aws_iam_role_policy" "opensearch_alerts" {
  name = "${terraform.workspace}-opensearch-alerts"
  role = aws_iam_role.opensearch_alerts.id

  policy = file("${path.module}/templates/policies/opensearch_sns_policy.pol.tpl")
}
