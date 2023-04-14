locals {
  cloudfront_origin_id = var.bucket_name

  route53_hosted_zone = var.global_config["environment"] == "mainnet" ? "node.glif.io" : "dev.node.glif.io"
}
