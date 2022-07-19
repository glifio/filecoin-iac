resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
  bucket = aws_s3_bucket.terraform-state.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_logging" "bucket_logging" {
  bucket        = aws_s3_bucket.terraform-state.id
  target_bucket = local.tf_state_s3_bucket
  target_prefix = "logs/"
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket_lifecycle" {
  bucket = aws_s3_bucket.terraform-state.id

  rule {
    id = "logs"

    expiration {
      days = 90
    }

    filter {
      prefix = "logs/"
    }
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.terraform-state.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket" "terraform-state" {
  bucket = local.tf_state_s3_bucket

  tags = merge(
    module.generator.common_tags,
    {
      Description = "Terraform State Storage"
    }
  )
}
