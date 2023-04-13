resource "aws_s3_bucket" "default" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_policy" "default" {
  bucket = aws_s3_bucket.default.id
  policy = data.aws_iam_policy_document.s3_bucket_default.json
}

data "aws_iam_policy_document" "s3_bucket_default" {
  statement {
    actions = ["s3:GetObject"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    resources = ["arn:aws:s3:::${var.bucket_name}/*"]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"

      values = [aws_cloudfront_distribution.default.arn]
    }
  }
}

resource "aws_s3_bucket_cors_configuration" "default" {
  bucket = aws_s3_bucket.default.bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST", "HEAD"]
    allowed_origins = ["*"]
    expose_headers = [
      "ETag",
      "Access-Control-Allow-Origin",
      "Connection",
      "Content-Length"
    ]
    max_age_seconds = 3000
  }

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}
