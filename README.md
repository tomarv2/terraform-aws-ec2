<p align="center">
    <a href="https://github.com/tomarv2/terraform-aws-ec2/actions/workflows/unit_test.yml" alt="Unit Tests">
        <img src="https://github.com/tomarv2/terraform-aws-ec2/actions/workflows/unit_test.yml/badge.svg?branch=main" /></a>
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

# terraform-aws-ec2
Terraform module for ec2

## The module does the following

Looks-up AMI ID from _**https://github.com/tomarv2/terraform-global**_
Create security group
Create load balancer
Create target group
Generates cloud-init userdata
Default tags
Launches instance

## Versions

- Module tested for Terraform 0.14.
- AWS provider version [3.29.0](https://registry.terraform.io/providers/hashicorp/aws/latest)
- `main` branch: Provider versions not pinned to keep up with Terraform releases
- `tags` releases: Tags are pinned with versions (use latest     
        <a href="https://github.com/tomarv2/terraform-aws-ec2/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-aws-ec2" /></a>
  in your releases)

**NOTE:** 

- Read more on [tfremote](https://github.com/tomarv2/tfremote)

## Usage

Recommended method:

- Create python 3.6+ virtual environment 
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
export PATH=$PATH:/usr/local/bin/
```  

- Update:
```
example/custom/sample.tfvars
```

- Change to: 
```
example/base
``` 

- Run and verify the output before deploying:
```
tf -cloud aws plan -var-file <path to .tfvars file>
```

- Run below to deploy:
```
tf -cloud aws apply -var-file <path to .tfvars file>
```

- Run below to destroy:
```
tf -cloud aws destroy -var-file <path to .tfvars file>
```

Please refer to example directory [link](example) for references.


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

