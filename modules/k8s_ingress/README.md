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

| <a name="input_get_global_configuration"></a> [get\_global\_configuration](#input\_get\_global\_configuration) | Basic AWS settings | `any` | n/a | yes |
| <a name="input_get_ingress_backend_service_name"></a> [get\_ingress\_backend\_service\_name](#input\_get\_ingress\_backend\_service\_name) | Service to forward request to | `string` | n/a | yes |
| <a name="input_get_ingress_backend_service_port"></a> [get\_ingress\_backend\_service\_port](#input\_get\_ingress\_backend\_service\_port) | Port to forward request to | `number` | n/a | yes |
| <a name="input_get_ingress_http_path"></a> [get\_ingress\_http\_path](#input\_get\_ingress\_http\_path) | Path to apply the rule to | `string` | n/a | yes |
| <a name="input_get_ingress_namespace"></a> [get\_ingress\_namespace](#input\_get\_ingress\_namespace) | Kubernetes namespace to deploy into | `string` | n/a | yes |
| <a name="input_get_ingress_pathType"></a> [get\_ingress\_pathType](#input\_get\_ingress\_pathType) | Match type of ingress rule | `string` | `"Exact"` | no |
| <a name="input_get_jwt_header_wr_token_name"></a> [get\_jwt\_header\_wr\_token\_name](#input\_get\_jwt\_header\_wr\_token\_name) | AWS SM secret name for JWT | `string` | `"jwt_token_kong_rw"` | no |
| <a name="input_get_rule_host"></a> [get\_rule\_host](#input\_get\_rule\_host) |Hostname to apply the rule to | `string` | n/a | yes |
| <a name="input_is_kong_auth_header_enabled"></a> [is\_kong\_auth\_header\_enabled](#input\_is\_kong\_auth\_header\_enabled) |  Modify `Authorization` header with JWT token from AWS SM if `true` | `bool` | `true` | no |
| <a name="input_is_kong_cors_enabled"></a> [is\_kong\_cors\_enabled](#input\_is\_kong\_cors\_enabled) | Enable CORS policies | `bool` | `true` | no |
| <a name="input_is_kong_transformer_header_enabled"></a> [is\_kong\_transformer\_header\_enabled](#input\_is\_kong\_transformer\_header\_enabled) | Replace URL according to `kong_plugin_replace_url` | `bool` | `true` | no |
| <a name="input_kong_plugin_replace_url"></a> [kong\_plugin\_replace\_url](#input\_kong\_plugin\_replace\_url) | Pattern on how to replace URL if `is_kong_transformer_header_enabled` | `string` | `"/$(uri_captures[1])"` | no |
| <a name="input_type_lb_scheme"></a> [type\_lb\_scheme](#input\_type\_lb\_scheme) | Ingress controller: `internal` of `external` | `string` | n/a | yes |
| <a name="input_is_kong_auth_header_block_public_access "></a> [is\_kong\_auth\_header\_block\_public\_access ](#input\_is_kong\_auth\_header\_block\_public\_access) | Block public access | `bool` | `true` | no |
