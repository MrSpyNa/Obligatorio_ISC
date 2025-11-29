## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.e-commerce_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.db_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_security_group.e-commerce_db_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_asg_sg_id"></a> [asg\_sg\_id](#input\_asg\_sg\_id) | Id del sg del asg | `string` | n/a | yes |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | value | `string` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | Lista de IDs de subredes privadas para el RDS Subnet Group | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID de la VPC, obtenido del módulo network | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_endpoint"></a> [db\_endpoint](#output\_db\_endpoint) | e-commerce-RDS |
| <a name="output_db_name"></a> [db\_name](#output\_db\_name) | Db\_name\_e-commerce |
| <a name="output_db_password"></a> [db\_password](#output\_db\_password) | Db\_password\_e-commerce |
| <a name="output_db_sg_id"></a> [db\_sg\_id](#output\_db\_sg\_id) | e-commerce-sg-RDS |
| <a name="output_db_user"></a> [db\_user](#output\_db\_user) | Db\_User\_e-commerce |
