resource "aws_route53_record" "main" {
  zone_id         = var.zone_id
  name            = "${var.get_nodegroup_name}.node.glif.io"
  allow_overwrite = var.allow_overwrite
  type            = var.type
  ttl             = var.ttl
  records         = var.records
}


