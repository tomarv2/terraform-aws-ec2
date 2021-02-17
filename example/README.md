# AWS EC2

Terraform to create EC2 on AWS.

**NOTE:** In most cases creating resources is heavily opinionated and or context-bound.

## Terraform versions

Terraform 0.12 

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_id | n/a | `any` | n/a | yes |
| aws\_region | The AWS region to create things in. | `string` | `"us-east-2"` | no |
| email | Team email, not individual email. Cannot be changed after running 'tf apply'. | `any` | n/a | yes |
| iam\_instance\_profile\_to\_use | IAM role to be used by instance | `any` | n/a | yes |
| key\_name | The SSH key name | `any` | n/a | yes |
| prjid | Name of the project/stack.  EG: mystack | `any` | n/a | yes |
| profile\_to\_use | Getting values from ~/.aws/credentials | `any` | n/a | yes |
| security\_groups\_to\_use | Security groups to use | `any` | n/a | yes |
| service\_ports | n/a | `any` | n/a | yes |
| teamid | Name of the team or group e.g. devops, dataengineering. Should not be changed after running 'tf apply'. | `any` | n/a | yes |
| user\_data | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| autoscaling\_group\_name | The name of the autoscaling group for the ECS container instances. |
| launch\_configuration\_name | The name of the launch configuration for the ECS container instances. |
| security\_group\_id | The ID of the default security group associated with the ECS container instances. |
