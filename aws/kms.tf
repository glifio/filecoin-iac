resource "aws_kms_key" "openseach_key" {
  description              = "KMS key for OpenSearch encryption on ${var.environment} environment level"
  key_usage                = local.key_usage
  customer_master_key_spec = local.key_spec
  deletion_window_in_days  = local.deletion_window
  is_enabled               = local.kms_enabled
  enable_key_rotation      = local.key_rotation
  tags                     = module.generator.common_tags
}

resource "aws_kms_alias" "s3_env_key_alias" {
  name          = "alias/${module.generator.prefix}/key-opensearch"
  target_key_id = aws_kms_key.openseach_key.key_id
}
