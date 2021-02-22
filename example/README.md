# AWS EC2

Terraform to create EC2 on AWS.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_id | n/a | `any` | n/a | yes |
| alb\_action\_type | n/a | `string` | `"forward"` | no |
| alb\_cert\_arn | n/a | `string` | `""` | no |
| alb\_ssl\_policy | n/a | `string` | `""` | no |
| aws\_region | The AWS region to create resources | `string` | `"us-west-2"` | no |
| create\_before\_destroy | n/a | `bool` | `true` | no |
| email | email address to be used for tagging (suggestion: use group email address) | `any` | n/a | yes |
| enable\_monitoring | target group | `string` | `"false"` | no |
| healthcheck\_interval | n/a | `string` | `"120"` | no |
| healthcheck\_matcher | n/a | `string` | `"200"` | no |
| healthcheck\_path | n/a | `string` | `"/"` | no |
| healthcheck\_retries | n/a | `number` | `2` | no |
| healthcheck\_start\_period | n/a | `number` | `120` | no |
| healthcheck\_timeout | n/a | `string` | `"30"` | no |
| healthy\_threshold | target group healthcheck threshold | `string` | `"2"` | no |
| iam\_instance\_profile\_to\_use | IAM instance profile | `any` | n/a | yes |
| is\_public | is the resource public | `string` | `"false"` | no |
| key\_name | The SSH key name (NOTE: key should pre-exist) | `any` | n/a | yes |
| lb\_port | n/a | `list` | <pre>[<br>  80<br>]</pre> | no |
| lb\_protocol | n/a | `string` | `"HTTP"` | no |
| lb\_type | load balancer type (network or application | `string` | `"application"` | no |
| prjid | (Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply' | `any` | n/a | yes |
| profile\_to\_use | Getting values from ~/.aws/credentials | `any` | n/a | yes |
| security\_groups\_to\_use | Existing Security groups to use | `any` | `null` | no |
| stickiness | Target group sticky configuration | <pre>object({<br>    cookie_duration = number<br>    enabled         = bool<br>  })</pre> | `null` | no |
| teamid | (Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply' | `any` | n/a | yes |
| unhealthy\_threshold | target group unheathy healthcheck threshold | `string` | `"2"` | no |
| user\_data\_file\_path | user data file path | `string` | `"scripts/userdata.sh"` | no |

## Outputs

| Name | Description |
|------|-------------|
| autoscaling\_group\_name | The name of the autoscaling group for the EC2 instances. |
| key\_used | n/a |
| launch\_configuration\_name | The name of the launch configuration for the EC2 instances. |
| security\_group\_id | The ID of the default security group associated with the EC2 instances. |
