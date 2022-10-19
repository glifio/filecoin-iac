# k8s_ingress

## Summary

This module provides resources to create and configure Kong ingress rules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_ingress_v1.ingress_kong](https://registry.terraform.io/providers/hashicorp/kubernetes/2.13.1/docs/resources/ingress_v1) | resource |
| [kubernetes_manifest.cors](https://registry.terraform.io/providers/hashicorp/kubernetes/2.13.1/docs/resources/manifest) | resource |
| [kubernetes_manifest.ip_restriction](https://registry.terraform.io/providers/hashicorp/kubernetes/2.13.1/docs/resources/manifest) | resource |
| [kubernetes_manifest.request_transformer_auth_header_replace_url](https://registry.terraform.io/providers/hashicorp/kubernetes/2.13.1/docs/resources/manifest) | resource |
| [kubernetes_manifest.request_transformer_replace_url_only](https://registry.terraform.io/providers/hashicorp/kubernetes/2.13.1/docs/resources/manifest) | resource |
| [random_string.rand](https://registry.terraform.io/providers/hashicorp/random/3.4.3/docs/resources/string) | resource |
| [aws_secretsmanager_secret.current](https://registry.terraform.io/providers/hashicorp/aws/4.30.0/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret_version.current](https://registry.terraform.io/providers/hashicorp/aws/4.30.0/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_as_is_ingress_backend_service_name"></a> [as\_is\_ingress\_backend\_service\_name](#input\_as\_is\_ingress\_backend\_service\_name) | Add `-service` at the end of the line if `false` | `bool` | `false` | no |
| <a name="input_enable_whitelist_ip"></a> [enable\_whitelist\_ip](#input\_enable\_whitelist\_ip) | Filter IP addresses if `true` | `bool` | `false` | no |
| <a name="input_get_global_configuration"></a> [get\_global\_configuration](#input\_get\_global\_configuration) | Basic AWS settings | `any` | n/a | yes |
| <a name="input_get_ingress_backend_service_name"></a> [get\_ingress\_backend\_service\_name](#input\_get\_ingress\_backend\_service\_name) | Service to forward request to | `string` | n/a | yes |
| <a name="input_get_ingress_backend_service_port"></a> [get\_ingress\_backend\_service\_port](#input\_get\_ingress\_backend\_service\_port) | Port to forward request to | `number` | n/a | yes |
| <a name="input_get_ingress_http_path"></a> [get\_ingress\_http\_path](#input\_get\_ingress\_http\_path) | Path to apply the rule to | `string` | n/a | yes |
| <a name="input_get_ingress_namespace"></a> [get\_ingress\_namespace](#input\_get\_ingress\_namespace) | Kubernetes namespace to deploy into | `string` | n/a | yes |
| <a name="input_get_ingress_pathType"></a> [get\_ingress\_pathType](#input\_get\_ingress\_pathType) | Match type of ingress rule | `string` | `"Exact"` | no |
| <a name="input_get_jwt_header_wr_token_name"></a> [get\_jwt\_header\_wr\_token\_name](#input\_get\_jwt\_header\_wr\_token\_name) | AWS SM secret name for JWT | `string` | `"jwt_token_kong_rw"` | no |
| <a name="input_get_rule_host"></a> [get\_rule\_host](#input\_get\_rule\_host) |Hostname to apply the rule to | `string` | n/a | yes |
| <a name="input_get_whitelist_ips"></a> [get\_whitelist\_ips](#input\_get\_whitelist\_ips) | Allowed IP addresses | `list` | <pre>[<br>  "212.58.119.174",<br>  "91.149.128.236",<br>  "216.144.250.150",<br>  "69.162.124.224/28",<br>  "63.143.42.240/28",<br>  "216.245.221.80/28",<br>  "46.137.190.132",<br>  "122.248.234.23",<br>  "188.226.183.141",<br>  "178.62.52.237",<br>  "54.79.28.129",<br>  "54.94.142.218",<br>  "104.131.107.63",<br>  "54.67.10.127",<br>  "54.64.67.106",<br>  "159.203.30.41",<br>  "46.101.250.135",<br>  "18.221.56.27",<br>  "52.60.129.180",<br>  "159.89.8.111",<br>  "146.185.143.14",<br>  "139.59.173.249",<br>  "165.227.83.148",<br>  "128.199.195.156",<br>  "138.197.150.151",<br>  "34.233.66.117"<br>]</pre> | no |
| <a name="input_is_kong_auth_header_enabled"></a> [is\_kong\_auth\_header\_enabled](#input\_is\_kong\_auth\_header\_enabled) |  Modify `Authorization` header with JWT token from AWS SM if `true` | `bool` | `true` | no |
| <a name="input_is_kong_cors_enabled"></a> [is\_kong\_cors\_enabled](#input\_is\_kong\_cors\_enabled) | Enable CORS policies | `bool` | `true` | no |
| <a name="input_is_kong_transformer_header_enabled"></a> [is\_kong\_transformer\_header\_enabled](#input\_is\_kong\_transformer\_header\_enabled) | Replace URL according to `kong_plugin_replace_url` | `bool` | `true` | no |
| <a name="input_kong_plugin_replace_url"></a> [kong\_plugin\_replace\_url](#input\_kong\_plugin\_replace\_url) | Pattern on how to replace URL if `is_kong_transformer_header_enabled` | `string` | `"/$(uri_captures[1])"` | no |
| <a name="input_type_lb_scheme"></a> [type\_lb\_scheme](#input\_type\_lb\_scheme) | Ingress controller: `internal` of `external` | `string` | n/a | yes |
| <a name="input_is_kong_auth_header_block_public_access "></a> [is\_kong\_auth\_header\_block\_public\_access ](#input\_is_kong\_auth\_header\_block\_public\_access) | Block public access | `bool` | `true` | no |
