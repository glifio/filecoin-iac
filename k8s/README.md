# k8s

## Summary

This module provides the most crusial parts of the infrastructrure application-wise, including API endpoints, cronjobs, ingress rules, etc.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ebs_controller_name"></a> [ebs\_controller\_name](#input\_ebs\_controller\_name) | Name of the EBS CSI driver | `string` | `"aws-ebs-csi-driver"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment: `dev` or `mainnet` | `string` | n/a | yes |
| <a name="input_http_endpoint_uri"></a> [http\_endpoint\_uri](#input\_http\_endpoint\_uri) | External URI to redirect to for some endpoints | `string` | n/a | yes |
| <a name="input_lb_controller_name"></a> [lb\_controller\_name](#input\_lb\_controller\_name) | Name of the ALB controller | `string` | `"aws-load-balancer-controller"` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | Terraform Workspace profile | `map(string)` | <pre>{<br>  "filecoin-dev-apn1-glif-eks": "filecoin",<br>  "filecoin-mainnet-apn1-glif-eks": "filecoin"<br>}</pre> | no |
| <a name="input_project"></a> [project](#input\_project) | Project name for prefixing | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region to deploy the infrastructure to | `string` | `"us-east-2"` | no |
| <a name="input_route53_domain"></a> [route53\_domain](#input\_route53\_domain) | Hosted zone to deploy Route53 records to | `any` | n/a | yes |
| <a name="input_sub_environment"></a> [sub\_environment](#input\_sub\_environment) | Subenvironment for prefixing | `string` | n/a | yes |
| <a name="input_sync_marketdeals_name"></a> [sync\_marketdeals\_name](#input\_sync\_marketdeals\_name) | K8s service account name for syncing market deals | `string` | `"sync-marketdeals"` | no |
| <a name="input_whitelist_ips"></a> [whitelist\_ips](#input\_whitelist\_ips) | Allowed IP addresses  | `any` | n/a | yes |