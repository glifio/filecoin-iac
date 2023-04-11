# Code for lambda #
data "archive_file" "lambda_index_zip" {
  type        = "zip"
  source_file  = "${path.module}/templates/cloudfront_cache/index.js"
  output_path = "${path.module}/templates/cloudfront_cache/index.zip"
}

# Lambda for request to api.uptimerobot #

resource "aws_lambda_function" "cloudfront_cache_s3" {
  function_name = "cloudfront_cache_s3"
  handler       = "index.handler"
  role          = aws_iam_role.cloudfront_cache_s3.arn
  filename         = data.archive_file.lambda_index_zip.output_path
  source_code_hash = data.archive_file.lambda_index_zip.output_base64sha256
  runtime       = "nodejs12.x"
  timeout       = 300
  lifecycle {
    ignore_changes = [
      layers
    ]
  }
  environment {
    variables = {
      api_key_hyperspace  = lookup(jsondecode(data.aws_secretsmanager_secret_version.cloudfront_cache_s3_key[0].secret_string), "api_key_hyperspace", null)
      api_key_mainnet     = lookup(jsondecode(data.aws_secretsmanager_secret_version.cloudfront_cache_s3_key[0].secret_string), "api_key_mainnet", null)
      api_key_calibration = lookup(jsondecode(data.aws_secretsmanager_secret_version.cloudfront_cache_s3_key[0].secret_string), "api_key_calibration", null)
    }
  }
}

# S3 bucket for cache to cloudfront #

resource "aws_s3_bucket" "cloudfront_cache_s3" {
  bucket = "cloudfront-cache-s3"
}

resource "aws_s3_bucket_policy" "cloudfront_cache_s3" {
  bucket = aws_s3_bucket.cloudfront_cache_s3.id
  policy = templatefile("${path.module}/templates/policies/cloudfront_cache_s3_policy.pol.tpl", {
  distribution_arn = aws_cloudfront_distribution.s3_distribution.arn })
}

resource "aws_s3_bucket_cors_configuration" "cloudfront_cache_s3" {
  bucket = aws_s3_bucket.cloudfront_cache_s3.bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST", "HEAD"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag", "Access-Control-Allow-Origin", "Connection", "Content-Length"]
    max_age_seconds = 3000
  }

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}

# Event rules for hyperspace, mainnet, calibration #

resource "aws_cloudwatch_event_rule" "main" {

  name                = "schedule_for_lambda_cache"
  event_bus_name      = "default"
  schedule_expression = "rate(1 minute)"
}

resource "aws_cloudwatch_event_target" "cloudfront_cache_s3_hyperspace" {
  arn  = aws_lambda_function.cloudfront_cache_s3.arn
  rule = aws_cloudwatch_event_rule.main.name
  retry_policy {
    maximum_retry_attempts       = 3
    maximum_event_age_in_seconds = 86400
  }
  input = <<DOC
{
  "network": "hyperspace"
}
DOC
}

resource "aws_cloudwatch_event_target" "cloudfront_cache_s3_mainnet" {
  arn  = aws_lambda_function.cloudfront_cache_s3.arn
  rule = aws_cloudwatch_event_rule.main.name
  retry_policy {
    maximum_retry_attempts       = 3
    maximum_event_age_in_seconds = 86400
  }
  input = <<DOC
{
  "network": "mainnet"
}
DOC
}

resource "aws_cloudwatch_event_target" "cloudfront_cache_s3_calibration" {
  arn  = aws_lambda_function.cloudfront_cache_s3.arn
  rule = aws_cloudwatch_event_rule.main.name
  retry_policy {
    maximum_retry_attempts       = 3
    maximum_event_age_in_seconds = 86400
  }
  input = <<DOC
{
  "network": "calibration"
}
DOC
}

resource "aws_lambda_permission" "cloudfront_cache_s3_hyperspace" {
  statement_id  = "${aws_lambda_function.cloudfront_cache_s3.function_name}-update-cache-s3-hyperspace"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.cloudfront_cache_s3.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.main.arn
}

resource "aws_lambda_permission" "cloudfront_cache_s3_mainnet" {
  statement_id  = "${aws_lambda_function.cloudfront_cache_s3.function_name}-update-cache-s3-mainnet"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.cloudfront_cache_s3.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.main.arn
}

resource "aws_lambda_permission" "cloudfront_cache_s3_calibration" {
  statement_id  = "${aws_lambda_function.cloudfront_cache_s3.function_name}-update-cache-s3-calibration"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.cloudfront_cache_s3.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.main.arn
}


locals {
  s3_origin_id = "cloudfront_cache"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.cloudfront_cache_s3.bucket_regional_domain_name
    origin_id   = local.s3_origin_id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "for uptimerobot"
  default_root_object = "index.html"

  aliases = ["uptimerobot.node.glif.io"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }


    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    acm_certificate_arn            = "arn:aws:acm:us-east-1:499623857295:certificate/1f3521a0-30ce-423c-b4ba-b466f46ad165"
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2021"
  }
}
