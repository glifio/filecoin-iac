# secrets_generator

## Summary

This module provides resources for creating a secret in AWS and importing it to Kubernetes.

## Usage example

Create a new secret:

The example will look like the following:
```
module "spacenet_secret" {
  source = "../modules/secrets_generator"

  name = "spacenet-public"

  generator_config = local.generator_config
}

```

### Import an existing AWS secret to Kubernetes.
The steps to import an existing secret to Kubernetes are the same as for creating a new one (look at the section above)\
except that we use the `from_secret` variable of the secrets_generator module to designate which AWS secret to import the data from.

The example will look like the following:
```
module "spacenet_slave_0_secret" {
source = "../modules/secrets_generator"

name        = "spacenet-public-slave-0"
from_secret = module.spacenet_secret.aws_secret_name

generator_config = local.generator_config
}
```


## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_generator"></a> [generator](#module\_generator) | ../generator | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [kubernetes_secret_v1.default](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret_v1) | resource |
| [aws_secretsmanager_secret.from](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret_version.from](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [external_external.secret](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_k8s_secret"></a> [create\_k8s\_secret](#input\_create\_k8s\_secret) | Create secret in Kubernetes | `bool` | `true` | no |
| <a name="input_from_secret"></a> [from\_secret](#input\_from\_secret) | Secret to copy secret\_string from | `string` | `""` | no |
| <a name="input_generator_config"></a> [generator\_config](#input\_generator\_config) | Configuration for the prefix generator | `map(any)` | n/a | yes |
| <a name="input_k8s_secret_postfix"></a> [k8s\_secret\_postfix](#input\_k8s\_secret\_postfix) | Postfix of the Kubernetes secret | `string` | `"-lotus-secret"` | no |
| <a name="input_name"></a> [name](#input\_name) | Secret name | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace of the Kubernetes secret | `string` | `"network"` | no |


## JWT token generator

If variable `from_secret` is empty then the module secret_generator will create a  secret  resource to AWS and put the data in the following format:
````
{
 "key_decoded": keyDecoded,
 "private_key": privateKey,
 "jwt_token": tokenFull,
 "jwt_token_kong_rw": tokenRw
}
````
When creating  Kubernetes secret uses data from AWS secret, like `["private_key"]`, `["jwt_token"]`.\
Pay attention, that Kubernetes transmits `privatekey` and `token` only and use a different naming in the following format:

```
  data = {
    privatekey = jsondecode(aws_secretsmanager_secret_version.default.secret_string)["private_key"]
    token      = jsondecode(aws_secretsmanager_secret_version.default.secret_string)["jwt_token"]
  }

```


## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_secret_name"></a> [aws\_secret\_name](#output\_aws\_secret\_name) | n/a |
