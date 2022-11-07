
output "s3_bucket_id" {
  value = aws_s3_bucket.cid_checker_market_deals.id
}

output "iam_role_name" {
  value = aws_iam_role.cid_checker_sync_market_deals.name
}

output "iam_role_policy_arn" {
  value = aws_iam_policy.cid_checker_sync_market_deals.arn
}

