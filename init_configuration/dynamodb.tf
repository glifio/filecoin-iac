resource "aws_dynamodb_table" "terraform-state-lock" {
  name           = local.tf_state_dynamodb_table
  hash_key       = "LockID"
  read_capacity  = 5
  write_capacity = 5

  point_in_time_recovery {
    enabled = true
  }

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = merge(
    module.generator.common_tags,
    {
      Description = "Terraform State Lock Table"
    }
  )
}
