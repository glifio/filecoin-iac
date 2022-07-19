resource "local_file" "set_backend_config" {
  content              = "bucket = \"${aws_s3_bucket.terraform-state.id}\"\ndynamodb_table = \"${aws_dynamodb_table.terraform-state-lock.id}\"\nregion = \"${var.region}\""
  filename             = "../${var.project}-${var.sub_environment}-${var.environment}-${module.generator.region_short}.hcl"
  file_permission      = "0755"
  directory_permission = "0755"
}

resource "random_string" "uid" {
  length  = 8
  lower   = true
  number  = true
  special = false
  upper   = false
}
