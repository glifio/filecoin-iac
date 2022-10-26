# init_configuration

## Summary

This module provides resources and configurations to spin up Terraform backend in AWS, including the S3 bucket and the DynamoDB table.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment: `dev` or `mainnet`| `string` | n/a | yes |
| <a name="input_profile"></a> [profile](#input\_profile) | Terraform Workspace profile | `map(string)` | <pre>{<br>  "filecoin-glif-dev-apn1": "filecoin",<br>  "filecoin-glif-mainnet-apn1": "filecoin"<br>}</pre> | no |
| <a name="input_project"></a> [project](#input\_project) | Project name for prefixing | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region to deploy the infrastructure to | `string` | n/a | yes |
| <a name="input_sub_environment"></a> [sub\_environment](#input\_sub\_environment) | Subenvironment for prefixing | `string` | n/a | yes |
| <a name="input_tf_state_dynamodb_table"></a> [tf\_state\_dynamodb\_table](#input\_tf\_state\_dynamodb\_table) | DynamoDB table to  lock.tfstate  | `string` | n/a | yes |
| <a name="input_tf_state_s3_bucket"></a> [tf\_state\_s3\_bucket](#input\_tf\_state\_s3\_bucket) | n/a | `string` | S3 bucket to store .tfstate into | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dynamodb_table_arn"></a> [dynamodb\_table\_arn](#output\_dynamodb\_table\_arn) | DynamoDB table ARN for .tfstate locking |
| <a name="output_dynamodb_table_name"></a> [dynamodb\_table\_name](#output\_dynamodb\_table\_name) | DynamoDB table name for .tfstate locking |
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | S3 bucket ARN where .tfstate is stored |
| <a name="output_s3_bucket_name"></a> [s3\_bucket\_name](#output\_s3\_bucket\_name) | S3 bucket name where .tfstate is stored |
