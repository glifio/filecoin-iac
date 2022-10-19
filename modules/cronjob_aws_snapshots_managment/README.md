# cronjob_aws_snapshots_management

## Summary

This module provides resources for making snapshots of dinamically created EBS volumes.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_creator_cron"></a> [creator\_cron](#input\_creator\_cron) | Schedule to create snapshots | `string` | `"0 0 * * *"` | no |
| <a name="input_deleter_cron"></a> [deleter\_cron](#input\_deleter\_cron) | Schedule to delete redundant snapshots | `string` | `"0 1 * * * "` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Target namespace | `string` | n/a | yes |
| <a name="input_snaps_to_keep"></a> [snaps\_to\_keep](#input\_snaps\_to\_keep) | How many snapshots to keep | `number` | n/a | yes |
| <a name="input_sts_name"></a> [sts\_name](#input\_sts\_name) | Stateful Set to snapshot | `string` | n/a | yes |
| <a name="input_volume_name_postfix"></a> [volume\_name\_postfix](#input\_volume\_name\_postfix) | Postfix for PVC name | `string` | `"lotus-0"` | no |
| <a name="input_volume_name_prefix"></a> [volume\_name\_prefix](#input\_volume\_name\_prefix) | Prefix for PVC name | `string` | `"vol-lotus"` | no |