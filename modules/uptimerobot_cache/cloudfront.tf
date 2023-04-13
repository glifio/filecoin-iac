resource "aws_cloudfront_distribution" "default" {
  comment = "Caching solution for UptimeRobot"

  price_class = "PriceClass_200"

  origin {
    domain_name = aws_s3_bucket.default.bucket_regional_domain_name
    origin_id   = local.cloudfront_origin_id
  }

  enabled         = true
  is_ipv6_enabled = true

  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = local.cloudfront_origin_id

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
    acm_certificate_arn      = aws_acm_certificate.default.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}
