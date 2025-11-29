## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_autoscaling"></a> [autoscaling](#module\_autoscaling) | ./Modules/autoscaling | n/a |
| <a name="module_database"></a> [database](#module\_database) | ./Modules/database | n/a |
| <a name="module_loadbalancer"></a> [loadbalancer](#module\_loadbalancer) | ./Modules/lb | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./Modules/VPC | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_key"></a> [access\_key](#input\_access\_key) | Access Key de Canvas AWS | `string` | n/a | yes |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Contraseña de la base de datos | `any` | n/a | yes |
| <a name="input_git_token"></a> [git\_token](#input\_git\_token) | Token GIT para acceso | `string` | n/a | yes |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | Secret Key de Canvas AWS | `string` | n/a | yes |
| <a name="input_token"></a> [token](#input\_token) | Session Token de Canvas AWS | `string` | n/a | yes |

## Outputs

No outputs.
