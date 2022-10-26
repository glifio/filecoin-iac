# cronjob_lotus_chain_snapshots

## Summary

This module provides resources to create and configure chain snapshots and store them in a gist.

## Resources

| Name | Type |
|------|------|
| [kubernetes_cron_job_v1.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cron_job_v1) | resource |
| [kubernetes_role_binding_v1.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding_v1) | resource |
| [kubernetes_role_v1.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_v1) | resource |
| [kubernetes_service_account_v1.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account_v1) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_blocks_to_export"></a> [blocks\_to\_export](#input\_blocks\_to\_export) | How many blocks to store in the snapshot | `number` | `900` | no |
| <a name="input_git_author"></a> [git\_author](#input\_git\_author) | Git commit author name | `string` | `"Protofire Bot"` | no |
| <a name="input_git_email"></a> [git\_email](#input\_git\_email) | Git commit author email | `string` | `"openworklabbot@gmail.com"` | no |
| <a name="input_git_repo"></a> [git\_repo](#input\_git\_repo) | Repository to store the snapshot in | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace to create the job in | `string` | n/a | yes |
| <a name="input_schedule"></a> [schedule](#input\_schedule) | Scheduler expression | `string` | `"0 0 * * *"` | no |
| <a name="input_sts_name"></a> [sts\_name](#input\_sts\_name) | Steteful set to make a snapshot of | `string` | n/a | yes |
| <a name="input_sts_name_postfix"></a> [sts\_name\_postfix](#input\_sts\_name\_postfix) | Stateful set postfix | `string` | `"lotus-0"` | no |
