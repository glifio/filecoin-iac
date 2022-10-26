# generator

The module is used for prefixing, common tags generation and other miscellanious generation tasks.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name | `any` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project name | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region name | `any` | n/a | yes |
| <a name="input_sub_environment"></a> [sub\_environment](#input\_sub\_environment) | Subenvironment name | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_common_tags"></a> [common\_tags](#output\_common\_tags) | The most common tags for resources tagging |
| <a name="output_prefix"></a> [prefix](#output\_prefix) | Prefix for resource names |
| <a name="output_prefix_account"></a> [prefix\_account](#output\_prefix\_account) | Account prefix |
| <a name="output_prefix_region"></a> [prefix\_region](#output\_prefix\_region) | Region prefix |
| <a name="output_region_short"></a> [region\_short](#output\_region\_short) | Region short name |
| <a name="output_uid"></a> [uid](#output\_uid) | Random UID |