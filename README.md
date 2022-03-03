<p align="center">
    <a href="https://github.com/tomarv2/terraform-aws-ec2/actions/workflows/pre-commit.yml" alt="Pre Commit">
        <img src="https://github.com/tomarv2/terraform-aws-ec2/actions/workflows/pre-commit.yml/badge.svg?branch=main" /></a>
    <a href="https://www.apache.org/licenses/LICENSE-2.0" alt="license">
        <img src="https://img.shields.io/github/license/tomarv2/terraform-aws-ec2" /></a>
    <a href="https://github.com/tomarv2/terraform-aws-ec2/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-aws-ec2" /></a>
    <a href="https://github.com/tomarv2/terraform-aws-ec2/pulse" alt="Activity">
        <img src="https://img.shields.io/github/commit-activity/m/tomarv2/terraform-aws-ec2" /></a>
    <a href="https://stackoverflow.com/users/6679867/tomarv2" alt="Stack Exchange reputation">
        <img src="https://img.shields.io/stackexchange/stackoverflow/r/6679867"></a>
    <a href="https://discord.gg/XH975bzN" alt="chat on Discord">
        <img src="https://img.shields.io/discord/813961944443912223?logo=discord"></a>
    <a href="https://twitter.com/intent/follow?screen_name=varuntomar2019" alt="follow on Twitter">
        <img src="https://img.shields.io/twitter/follow/varuntomar2019?style=social&logo=twitter"></a>
</p>

# Terraform module for AWS EC2

#### The module looks up for AMI ID from: _**https://github.com/tomarv2/terraform-global**_

## Versions

- Module tested for Terraform 1.0.1.
- AWS provider version [3.63](https://registry.terraform.io/providers/hashicorp/aws/latest)
- `main` branch: Provider versions not pinned to keep up with Terraform releases
- `tags` releases: Tags are pinned with versions (use <a href="https://github.com/tomarv2/terraform-aws-ec2/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-aws-ec2" /></a> in your releases)

**NOTE:**

- Read more on [tfremote](https://github.com/tomarv2/tfremote)

## Usage

Recommended method:

- Create python 3.8+ virtual environment
```
python3 -m venv <venv name>
```

- Install package:
```
pip install tfremote
```

- Set below environment variables:
```
export TF_AWS_BUCKET=<remote state bucket name>
export TF_AWS_PROFILE=default
export TF_AWS_BUCKET_REGION=us-west-2
```

- Updated `examples` directory with required values.

- Run and verify the output before deploying:
```
tf -cloud aws plan -var='teamid=foo' -var='prjid=bar'
```

- Run below to deploy:
```
tf -cloud aws apply -var='teamid=foo' -var='prjid=bar'
```

- Run below to destroy:
```
tf -cloud aws destroy -var='teamid=foo' -var='prjid=bar'
```

> ❗️ **Important** - Two variables are required for using `tf` package:
>
> - teamid
> - prjid
>
> These variables are required to set backend path in the remote storage.
> Variables can be defined using:
>
> - As `inline variables` e.g.: `-var='teamid=demo-team' -var='prjid=demo-project'`
> - Inside `.tfvars` file e.g.: `-var-file=<tfvars file location> `
>
> For more information refer to [Terraform documentation](https://www.terraform.io/docs/language/values/variables.html)

#### EC2 with Target Group, Load Balancer, and Security Group
```
locals {
  security_group = var.security_groups != null ? flatten([module.security_group.security_group_id, var.security_groups]) : flatten([module.security_group.security_group_id])
}

module "ec2" {
  source = "../"

  security_groups      = module.security_group.security_group_id
  key_name                    = "demo_key"
  iam_instance_profile = "arn:aws:iam::123456789012:instance-profile/rumse-demo-role"
  account_id                  = "123456789012"
  #-----------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}

module "target_group" {
  source = "git::git@github.com:tomarv2/terraform-aws-target-group.git?ref=v0.0.1"

  teamid     = var.teamid
  prjid      = var.prjid
  account_id = "123456789012"
}

module "lb" {
  source = "git::git@github.com:tomarv2/terraform-aws-lb.git?ref=v0.0.1"

  teamid     = var.teamid
  prjid      = var.prjid
  account_id = "123456789012"

  target_group_arn       = module.target_group.target_group_arn
  security_groups = local.security_group
}

module "security_group" {
  source = "git::git@github.com:tomarv2/terraform-aws-security-group.git?ref=v0.0.1"

  teamid = var.teamid
  prjid  = var.prjid
}
```

Please refer to examples directory [link](examples) for references.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.63 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.63 |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_global"></a> [global](#module\_global) | git::git@github.com:tomarv2/terraform-global.git//aws | v0.0.1 |

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_launch_configuration.launchcfg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [template_cloudinit_config.cloudinit](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/cloudinit_config) | data source |
| [template_file.shell_script](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | AWS account id (used to pull values from shared base module like vpc info, subnet ids) | `string` | n/a | yes |
| <a name="input_asg_cooldown"></a> [asg\_cooldown](#input\_asg\_cooldown) | time between a scaling activity and the succeeding scaling activity | `string` | `"300"` | no |
| <a name="input_asg_desired"></a> [asg\_desired](#input\_asg\_desired) | The desired number of instances for the autoscaling group | `string` | `1` | no |
| <a name="input_asg_health_check_type"></a> [asg\_health\_check\_type](#input\_asg\_health\_check\_type) | can be EC2 or ELB | `string` | `"EC2"` | no |
| <a name="input_asg_health_grace_period"></a> [asg\_health\_grace\_period](#input\_asg\_health\_grace\_period) | How long to wait for instance to come up and start doing health checks | `number` | `600` | no |
| <a name="input_asg_max"></a> [asg\_max](#input\_asg\_max) | The maximum number of instances for the autoscaling group | `string` | `1` | no |
| <a name="input_asg_min"></a> [asg\_min](#input\_asg\_min) | The minimum number of instances for the autoscaling group | `string` | `1` | no |
| <a name="input_associate_public_ip"></a> [associate\_public\_ip](#input\_associate\_public\_ip) | associate public ip to launch configuration | `string` | `"true"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to create resources | `string` | `null` | no |
| <a name="input_deploy_ec2"></a> [deploy\_ec2](#input\_deploy\_ec2) | feature flag, true or false | `bool` | `true` | no |
| <a name="input_enable_monitoring"></a> [enable\_monitoring](#input\_enable\_monitoring) | enable monitoring of launch configuration | `string` | `"false"` | no |
| <a name="input_force_delete"></a> [force\_delete](#input\_force\_delete) | forcefully delete asg | `string` | `"true"` | no |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile\_to\_use](#input\_iam\_instance\_profile\_to\_use) | IAM instance profile | `string` | n/a | yes |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | image id to use for deployment if none is provided a default will be used | `string` | `null` | no |
| <a name="input_inst_type"></a> [inst\_type](#input\_inst\_type) | aws instance type | `string` | `"t2.small"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | The SSH key name (NOTE: key should pre-exist) | `string` | n/a | yes |
| <a name="input_prjid"></a> [prjid](#input\_prjid) | (Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply' | `string` | n/a | yes |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | In gigabytes, must be at least 8 | `number` | `30` | no |
| <a name="input_root_volume_type"></a> [root\_volume\_type](#input\_root\_volume\_type) | can be standard or gp2 | `string` | `"gp2"` | no |
| <a name="input_security_groups"></a> [security\_groups\_to\_use](#input\_security\_groups\_to\_use) | Security groups to use | `list(any)` | `[]` | no |
| <a name="input_teamid"></a> [teamid](#input\_teamid) | (Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply' | `string` | n/a | yes |
| <a name="input_user_data_file_path"></a> [user\_data\_file\_path](#input\_user\_data\_file\_path) | user data file path | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_autoscaling_group_arn"></a> [autoscaling\_group\_arn](#output\_autoscaling\_group\_arn) | The name of the autoscaling group. |
| <a name="output_autoscaling_group_name"></a> [autoscaling\_group\_name](#output\_autoscaling\_group\_name) | The name of the autoscaling group. |
| <a name="output_key_used"></a> [key\_used](#output\_key\_used) | The key used to create the resources. |
| <a name="output_launch_configuration_name"></a> [launch\_configuration\_name](#output\_launch\_configuration\_name) | The name of the launch configuration. |
