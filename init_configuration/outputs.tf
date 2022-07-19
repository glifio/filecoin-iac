output "s3_bucket_name" {
  value = aws_s3_bucket.terraform-state.id
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.terraform-state.arn
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.terraform-state-lock.id
}

output "dynamodb_table_arn" {
  value = aws_dynamodb_table.terraform-state-lock.arn
}
