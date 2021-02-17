# terraform-aws-ec2
Terraform module for ec2

**The module does the following:**

Looks-up AMI ID from _**https://github.com/tomarv2/terraform-global**_
Create security group
Create load balancer
Create target group
Generates cloud-init userdata
Default tags
Launches instance

## How to use

**Recommended method:**

- Install tfremote package: `pip install tfremote`

- Change to `example/base` directory

- `tf -cloud aws plan -var-file <tfvars file path>`

- `tf -cloud aws apply -var-file <tfvars file path>`

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14 |
| aws | ~> 2.61 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.61 |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_id | (Required) AWS account id (used to pull values from shared base module like vpc info, subnet ids) | `any` | n/a | yes |
| asg\_cooldown | time between a scaling activity and the succeeding scaling activity | `string` | `"300"` | no |
| asg\_desired | The desired number of instances for the autoscaling group | `number` | `1` | no |
| asg\_health\_check\_type | can be EC2 or ELB | `string` | `"EC2"` | no |
| asg\_health\_grace\_period | How long to wait for instance to come up and start doing health checks | `number` | `600` | no |
| asg\_max | The maximum number of instances for the autoscaling group | `number` | `1` | no |
| asg\_min | The minimum number of instances for the autoscaling group | `number` | `1` | no |
| associate\_public\_ip | associate public ip to launch configuration | `string` | `"true"` | no |
| aws\_region | The AWS region to create resources | `string` | `"us-west-2"` | no |
| az\_count | Number of AZs to cover in a given AWS region | `string` | `"2"` | no |
| create\_before\_destroy | lifecycle for asg | `bool` | `true` | no |
| ebs\_vol\_name | name of ebs volume | `string` | `"/dev/xvdh"` | no |
| ebs\_vol\_size | size of ebs volume | `string` | `"10"` | no |
| ebs\_vol\_type | type of ebs volume | `string` | `"gp2"` | no |
| efs\_to\_mount | (Optional) EFS to mount for persistent storage | `string` | `""` | no |
| email | email address to be used for tagging (suggestion: use group email address) | `any` | n/a | yes |
| enable\_monitoring | enable monitoring of launch configuration | `string` | `"false"` | no |
| force\_delete | forcefully delete asg | `string` | `"true"` | no |
| iam\_instance\_profile\_to\_use | IAM instance profile | `any` | n/a | yes |
| image\_id | image id to use for deployment if none is provided a default will be used | `any` | `null` | no |
| inst\_type | aws instance type | `string` | `"t2.small"` | no |
| key\_name | The SSH key name (NOTE: key should pre-exist) | `any` | n/a | yes |
| os\_release | ami os release | `string` | `"test_ops_latest"` | no |
| os\_version | ami os version | `string` | `"Centos7X86_64"` | no |
| prjid | (Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply' | `any` | n/a | yes |
| profile\_to\_use | Getting values from ~/.aws/credentials | `string` | `"default"` | no |
| root\_volume\_size | In gigabytes, must be at least 8 | `number` | `30` | no |
| root\_volume\_type | can be standard or gp2 | `string` | `"gp2"` | no |
| security\_groups\_to\_use | Security groups to use | `list` | `[]` | no |
| spot-instance-price | set to blank to use on-demand pricing | `string` | `""` | no |
| stickiness | target group sticky configuration | <pre>object({<br>    cookie_duration = number<br>    enabled         = bool<br>  })</pre> | `null` | no |
| teamid | (Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply' | `any` | n/a | yes |
| user\_data\_file\_path | user data file path | `string` | `"scripts/userdata.sh"` | no |

## Outputs

| Name | Description |
|------|-------------|
| autoscaling\_group\_arn | The name of the autoscaling group. |
| autoscaling\_group\_name | The name of the autoscaling group. |
| key\_used | The key used to create the resources. |
| launch\_configuration\_name | The name of the launch configuration. |
