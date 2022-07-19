locals {
  tf_state_s3_bucket      = signum(length(var.tf_state_s3_bucket)) >= 1 ? var.tf_state_s3_bucket : "${var.project}-${module.generator.region_short}-${var.environment}-tf-state-${random_string.uid.result}"
  tf_state_dynamodb_table = signum(length(var.tf_state_dynamodb_table)) >= 1 ? var.tf_state_dynamodb_table : "${var.project}-${module.generator.region_short}-${var.environment}-tf-state-${random_string.uid.result}"
}
