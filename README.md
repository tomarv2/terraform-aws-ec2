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
<<<<<<< HEAD
  key_name             = "demo_key"
  iam_instance_profile = "arn:aws:iam::123456789012:instance-profile/rumse-demo-role"
  account_id           = "123456789012"
=======
  key_name                    = "demo_key"
  iam_instance_profile = "arn:aws:iam::123456789012:instance-profile/rumse-demo-role"
  account_id                  = "123456789012"
>>>>>>> 5e7893b95a2f32ca563b9baecd16c837ee2ecee8
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

<<<<<<< HEAD
  target_group_arn = module.target_group.target_group_arn
  security_groups  = local.security_group
=======
  target_group_arn       = module.target_group.target_group_arn
  security_groups = local.security_group
>>>>>>> 5e7893b95a2f32ca563b9baecd16c837ee2ecee8
}

module "security_group" {
  source = "git::git@github.com:tomarv2/terraform-aws-security-group.git?ref=v0.0.1"

  teamid = var.teamid
  prjid  = var.prjid
}
```

Please refer to examples directory [link](examples) for references.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.63.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_common"></a> [common](#module\_common) | git::git@github.com:tomarv2/terraform-global.git//common | v0.0.1 |
| <a name="module_ec2"></a> [ec2](#module\_ec2) | ../../ | n/a |
| <a name="module_lb"></a> [lb](#module\_lb) | git::git@github.com:tomarv2/terraform-aws-lb.git | v0.0.5 |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | git::git@github.com:tomarv2/terraform-aws-security-group.git | v0.0.5 |
| <a name="module_target_group"></a> [target\_group](#module\_target\_group) | git::git@github.com:tomarv2/terraform-aws-target-group.git | v0.0.4 |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | AWS account id (used to pull values from shared base module like vpc info, subnet ids) | `string` | `null` | no |
| <a name="input_alb_cert_arn"></a> [alb\_cert\_arn](#input\_alb\_cert\_arn) | alb cert arn | `string` | `""` | no |
| <a name="input_alb_ssl_policy"></a> [alb\_ssl\_policy](#input\_alb\_ssl\_policy) | alb ssl policy | `string` | `""` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to create resources | `string` | `null` | no |
| <a name="input_deploy_lb"></a> [deploy\_lb](#input\_deploy\_lb) | feature flag, true or false | `bool` | `true` | no |
| <a name="input_deploy_security_group"></a> [deploy\_security\_group](#input\_deploy\_security\_group) | feature flag, true or false | `bool` | `true` | no |
| <a name="input_deploy_target_group"></a> [deploy\_target\_group](#input\_deploy\_target\_group) | feature flag, true or false | `bool` | `true` | no |
| <a name="input_healthcheck_interval"></a> [healthcheck\_interval](#input\_healthcheck\_interval) | target group healthcheck interval | `string` | `""` | no |
| <a name="input_healthcheck_matcher"></a> [healthcheck\_matcher](#input\_healthcheck\_matcher) | healthcheck matcher (e.g. 200) | `string` | `""` | no |
| <a name="input_healthcheck_path"></a> [healthcheck\_path](#input\_healthcheck\_path) | target group healthcheck path | `string` | `""` | no |
| <a name="input_healthcheck_timeout"></a> [healthcheck\_timeout](#input\_healthcheck\_timeout) | target group healthcheck timeout | `string` | `""` | no |
| <a name="input_healthy_threshold"></a> [healthy\_threshold](#input\_healthy\_threshold) | target group healthcheck threshold | `string` | `""` | no |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | iam instance profile | `string` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | aws ssh key name | `string` | n/a | yes |
| <a name="input_lb_port"></a> [lb\_port](#input\_lb\_port) | Load balancer type | `list(any)` | <pre>[<br>  80<br>]</pre> | no |
| <a name="input_lb_protocol"></a> [lb\_protocol](#input\_lb\_protocol) | type of load balancer (e.g. HTTP, TCP, etc) | `string` | `"HTTP"` | no |
| <a name="input_lb_type"></a> [lb\_type](#input\_lb\_type) | load balancer type (network or application | `string` | `"application"` | no |
| <a name="input_prjid"></a> [prjid](#input\_prjid) | (Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply' | `string` | n/a | yes |
| <a name="input_profile"></a> [profile](#input\_profile) | aws profile to use | `string` | `"default"` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | Security groups to use | `list(any)` | `[]` | no |
| <a name="input_target_group_port"></a> [target\_group\_port](#input\_target\_group\_port) | target group ports | `list(number)` | `null` | no |
| <a name="input_target_group_protocol"></a> [target\_group\_protocol](#input\_target\_group\_protocol) | type of load balancer (e.g. HTTP, TCP, etc) | `string` | `null` | no |
| <a name="input_teamid"></a> [teamid](#input\_teamid) | (Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply' | `string` | n/a | yes |
| <a name="input_unhealthy_threshold"></a> [unhealthy\_threshold](#input\_unhealthy\_threshold) | target group unheathy healthcheck threshold | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_autoscaling_group_name"></a> [autoscaling\_group\_name](#output\_autoscaling\_group\_name) | The name of the autoscaling group for the EC2 instances. |
| <a name="output_key_used"></a> [key\_used](#output\_key\_used) | The key used to create the resources. |
| <a name="output_launch_configuration_name"></a> [launch\_configuration\_name](#output\_launch\_configuration\_name) | The name of the launch configuration for the EC2 instances. |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group associated with the EC2 instances. |
