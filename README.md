# terraform-aws-ec2
Terraform module for ec2

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| aws | ~> 2.61 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.61 |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_id | n/a | `any` | n/a | yes |
| alb\_action\_type | n/a | `string` | `"forward"` | no |
| alb\_is\_public | n/a | `string` | `"false"` | no |
| alb\_listener\_port | n/a | `string` | `"80"` | no |
| alb\_listener\_protocol | n/a | `string` | `"HTTP"` | no |
| alb\_target\_group\_port | n/a | `string` | `"80"` | no |
| alb\_target\_group\_protocol | n/a | `string` | `"HTTP"` | no |
| alb\_type | n/a | `string` | `"application"` | no |
| asg\_cooldown | time between a scaling activity and the succeeding scaling activity | `string` | `"300"` | no |
| asg\_desired | The desired number of instances for the autoscaling group | `number` | `1` | no |
| asg\_health\_check\_type | Can be EC2 or ELB | `string` | `"EC2"` | no |
| asg\_health\_grace\_period | How long to wait for instance to come up and start doing health checks | `number` | `600` | no |
| asg\_max | The maximum number of instances for the autoscaling group | `number` | `1` | no |
| asg\_min | The minimum number of instances for the autoscaling group | `number` | `1` | no |
| assoicate\_public\_ip | n/a | `string` | `"true"` | no |
| aws\_region | The AWS region to create things in. | `string` | `"us-east-2"` | no |
| az\_count | Number of AZs to cover in a given AWS region | `string` | `"2"` | no |
| create\_before\_destroy | n/a | `bool` | `true` | no |
| deployment\_maximum\_percent | n/a | `string` | `"100"` | no |
| deployment\_minimum\_healthy\_percent | n/a | `string` | `"0"` | no |
| ebs\_vol\_name | name of ebs volume | `string` | `"/dev/xvdh"` | no |
| ebs\_vol\_size | size of ebs volume | `string` | `"100"` | no |
| ebs\_vol\_type | type of ebs volume | `string` | `"gp2"` | no |
| efs\_to\_mount | n/a | `string` | `""` | no |
| email | Team email, not individual email. Cannot be changed after running 'tf apply'. | `any` | n/a | yes |
| enable\_monitoring | n/a | `string` | `"false"` | no |
| force\_delete | n/a | `string` | `"true"` | no |
| healthcheck\_interval | n/a | `string` | `"120"` | no |
| healthcheck\_matcher | n/a | `string` | `"200"` | no |
| healthcheck\_path | n/a | `string` | `"/healthcheck"` | no |
| healthcheck\_port | n/a | `string` | `"80"` | no |
| healthcheck\_retries | n/a | `number` | `2` | no |
| healthcheck\_start\_period | n/a | `number` | `120` | no |
| healthcheck\_timeout | n/a | `string` | `"30"` | no |
| healthy\_threshold | n/a | `string` | `"2"` | no |
| iam\_instance\_profile\_to\_use | IAM role to be used by instance | `any` | n/a | yes |
| inst\_type | The AWS instance type | `string` | `"t2.medium"` | no |
| key\_name | The SSH key name | `any` | n/a | yes |
| os\_release | The AMI OS release. | `string` | `"test_ops_latest"` | no |
| os\_version | The AMI OS version. | `string` | `"Centos7X86_64"` | no |
| prjid | Name of the project/stack.  EG: mystack | `any` | n/a | yes |
| profile\_to\_use | Getting values from ~/.aws/credentials | `any` | n/a | yes |
| root\_volume\_size | In gigabytes, must be at least 8 | `number` | `30` | no |
| root\_volume\_type | Can be standard or gp2 | `string` | `"gp2"` | no |
| security\_groups\_to\_use | Security groups to use | `any` | n/a | yes |
| service\_ports | n/a | `any` | n/a | yes |
| spot-instance-price | Set to blank to use on-demand pricing | `string` | `""` | no |
| teamid | Name of the team or group e.g. devops, dataengineering. Should not be changed after running 'tf apply'. | `any` | n/a | yes |
| unhealthy\_threshold | n/a | `string` | `"2"` | no |
| user\_data | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| alb\_listener | n/a |
| alb\_target\_group\_id | n/a |
| alb\_zoneid | n/a |
| autoscaling\_group\_name | The name of the autoscaling group. |
| key\_used | The key used to create the resources. |
| launch\_configuration\_name | The name of the launch configuration. |
| security\_group\_id | The ID of the default security group associated. |

## TODO:

fix issue with SG group deletion when attached to another SG
