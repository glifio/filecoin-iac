# aws

## Summmary

This module provides the most low-level parts of the infrasructure, including networking, EKS cluster setup, etc.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azs_count"></a> [azs\_count](#input\_azs\_count) | Availability zones to deploy the infrastructure to | `number` | `3` | no |
| <a name="input_branch"></a> [branch](#input\_branch) | Git branch for CodeBuild config | `string` | n/a | yes |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | CIDR block for EKS cluster | `string` | `"192.168.0.0/16"` | no |
| <a name="input_eks_cluster_version"></a> [eks\_cluster\_version](#input\_eks\_cluster\_version) | EKS version | `string` | `"1.23"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment: `dev` or `mainnet` | `string` | n/a | yes |
| <a name="input_git_configuration"></a> [git\_configuration](#input\_git\_configuration) | Git config for CodeBuild | `any` | n/a | yes |
| <a name="input_profile"></a> [profile](#input\_profile) | Terraform Workspace profile | `map(string)` | <pre>{<br>  "default": "_dont_use_default_namespace",<br>  "filecoin-glif-dev-apn1": "filecoin",<br>  "filecoin-glif-mainnet-apn1": "filecoin"<br>}</pre> | no |
| <a name="input_project"></a> [project](#input\_project) | Project name for prefixing | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region to deploy the infrastructure to | `string` | `"us-east-2"` | no |
| <a name="input_route53_domain"></a> [route53\_domain](#input\_route53\_domain) | Hosted zone to deploy Route53 records to | `string` | n/a | yes |
| <a name="input_sub_environment"></a> [sub\_environment](#input\_sub\_environment) | Subenvironment for prefixing | `string` | n/a | yes |
