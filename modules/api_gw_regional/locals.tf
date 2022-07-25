locals {
  get_project         = lookup(var.get_global_configuration, "project", "")
  get_region          = lookup(var.get_global_configuration, "region", "")
  get_environment     = lookup(var.get_global_configuration, "environment", "")
  get_sub_environment = lookup(var.get_global_configuration, "sub_environment", "")
  get_route53_domain  = lookup(var.get_global_configuration, "route53_domain", "")



  make_internal_lb_domain_name = "https://${local.get_environment}-internal.${local.get_route53_domain}"
}
