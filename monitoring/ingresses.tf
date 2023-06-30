module "ingress_monitoring" {
  name   = "monitoring"
  source = "../modules/ovh_ingress"

  namespace = "monitoring"

  incress_class = local.ingress_class

  http_host      = aws_route53_record.monitoring.name
  http_path      = "/"
  http_path_type = "Prefix"

  service_name = "monitoring-grafana"
  service_port = 80

  enable_path_transformer = false
  enable_return_json      = false
  enable_letsencrypt      = false
}
