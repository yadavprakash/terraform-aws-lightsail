# Terraform Infrastructure as Code (IaC) - terraform aws lightsail Module

## Table of Contents
- [Introduction](#introduction)
- [Usage](#usage)
- [Module Inputs](#module-inputs)
- [Module Outputs](#module-outputs)
- [Authors](#authors)
- [License](#license)

## Introduction
This Terraform module creates structured lightsail for Azure resources with specific attributes.

## Usage

- Use the module by referencing its source and providing the required variables.
#  Examples

```hcl
module "lightsail" {
source               = "git::https://github.com/opsstation/terraform-aws-lightsail.git?ref=v1.0.0"
environment          = "test"
name                 = "lightsail"
label_order          = ["name", "environment"]
public_key           = "ssh-rsa AvxxxxxxxxxxxxxxxxxxxxHNvIFfq85EGSUmjY3Z6sXV4Uynoj"
use_default_key_pair = true
instance_count       = 1
user_data            = file("${path.module}/lightsail.sh")

port_info = [
{
port     = 80
protocol = "tcp"
cidrs    = ["0.0.0.0/0"]
},
{
port     = 22
protocol = "tcp"
cidrs    = ["0.0.0.0/0"]
}
]
}
```
Please ensure you specify the correct 'source' path for the module.

## Module Inputs

- 'name'       : The name for the bucket.
- 'environment':  The environment for the resources.
- 'label_order':  The order of labels for naming resources.
- 'delimiter'  :  Delimiter to be used between `organization`, `environment`, `name` and `attributes`.
- 'repository' :  Terraform current module repo.
- 'availability_zone' :  The Availability Zone in which to create your instance.
- 'blueprint_id' :  The bundle of specification information.
- 'managedby' : ManagedBy, eg 'opsstation'.
- 'blueprint_id' : The ID for a virtual private server image.
- 'key_pair_name' : The key name to use for the instance.


## Module Outputs
- - `arn`: The ARN of the lightsail bucket.
- `created_at`:The timestamp when the bucket was created.
- Other relevant security group outputs (modify as needed).

# Examples
For detailed examples on how to use this module, please refer to the '[example](https://github.com/opsstation/terraform-aws-lightsail/tree/master/_example)' directory within this repository.

## Authors
Your Name
Replace '[License Name]' and '[Your Name]' with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.

## License
This project is licensed under the MIT License - see the [LICENSE](https://github.com/opsstation/terraform-aws-lightsail/blob/master/LICENSE) file for details.



<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.9.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_labels"></a> [labels](#module\_labels) | git::https://github.com/opsstation/terraform-aws-labels.git | v1.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_lightsail_domain.test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lightsail_domain) | resource |
| [aws_lightsail_instance.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lightsail_instance) | resource |
| [aws_lightsail_instance_public_ports.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lightsail_instance_public_ports) | resource |
| [aws_lightsail_key_pair.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lightsail_key_pair) | resource |
| [aws_lightsail_static_ip.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lightsail_static_ip) | resource |
| [aws_lightsail_static_ip_attachment.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lightsail_static_ip_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attributes"></a> [attributes](#input\_attributes) | Additional attributes (e.g. `1`). | `list(any)` | `[]` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | The Availability Zone in which to create your instance | `string` | `"us-east-1a"` | no |
| <a name="input_blueprint_id"></a> [blueprint\_id](#input\_blueprint\_id) | The ID for a virtual private server image | `string` | `"ubuntu_20_04"` | no |
| <a name="input_bundle_id"></a> [bundle\_id](#input\_bundle\_id) | The bundle of specification information | `string` | `"nano_2_0"` | no |
| <a name="input_create_static_ip"></a> [create\_static\_ip](#input\_create\_static\_ip) | Create and attach a statis IP to the instance | `bool` | `false` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between `organization`, `environment`, `name` and `attributes`. | `string` | `"-"` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | This is the name of the resource. | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT' | `string` | n/a | yes |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of instances to launch. | `number` | `1` | no |
| <a name="input_instance_enabled"></a> [instance\_enabled](#input\_instance\_enabled) | Flag to control the instance creation. | `bool` | `true` | no |
| <a name="input_key_pair_name"></a> [key\_pair\_name](#input\_key\_pair\_name) | The key name to use for the instance. | `string` | `""` | no |
| <a name="input_key_path"></a> [key\_path](#input\_key\_path) | Public key path  (e.g. `~/.ssh/id_rsa.pub`). | `string` | `""` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | Label order, e.g. `name`,`application`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| <a name="input_managedby"></a> [managedby](#input\_managedby) | ManagedBy, eg 'opsstation'. | `string` | `"opsstation"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| <a name="input_pgp_key"></a> [pgp\_key](#input\_pgp\_key) | Flag to control the instance creation. | `string` | `""` | no |
| <a name="input_port_info"></a> [port\_info](#input\_port\_info) | n/a | <pre>list(object({<br>    protocol = string<br>    port     = number<br>    cidrs    = list(string)<br>  }))</pre> | `null` | no |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | The public key material. This public key will be imported into Lightsail. | `string` | `""` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Terraform current module repo | `string` | `"https://github.com/opsstation/terraform-aws-lightsail"` | no |
| <a name="input_use_default_key_pair"></a> [use\_default\_key\_pair](#input\_use\_default\_key\_pair) | Default key pair name will be used, you must keep 'key\_pair\_name' empty | `bool` | `true` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | Single lined launch script as a string to configure server with additional user data. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the Lightsail instance. |
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | The timestamp when the instance was created. |
| <a name="output_instance_ip"></a> [instance\_ip](#output\_instance\_ip) | The Public IP Address name of the Lightsail instance. |
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | The name of the Lightsail instance. |
| <a name="output_ssh_host_public_key"></a> [ssh\_host\_public\_key](#output\_ssh\_host\_public\_key) | n/a |
| <a name="output_tags"></a> [tags](#output\_tags) | A mapping of tags to assign to the resource. |
<!-- END_TF_DOCS -->