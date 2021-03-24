variable "teamid" {
  description = "(Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply'"
}

variable "prjid" {
  description = "(Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply'"
}

variable "key_name" {
  description = "The SSH key name (NOTE: key should pre-exist)"
}

variable "account_id" {
  description = "(Required) AWS account id (used to pull values from shared base module like vpc info, subnet ids)"
}

variable "profile_to_use" {
  description = "Getting values from ~/.aws/credentials"
  default     = "default"
}
variable "iam_instance_profile_to_use" {
  description = "IAM instance profile"
}

variable "security_groups_to_use" {
  description = "Security groups to use"
  default     = []
}

variable "aws_region" {
  description = "The AWS region to create resources"
  default     = "us-west-2"
}

variable "az_count" {
  description = "Number of AZs to cover in a given AWS region"
  default     = "2"
}

variable "asg_min" {
  default     = 1
  description = "The minimum number of instances for the autoscaling group"
}

variable "asg_desired" {
  default     = 1
  description = "The desired number of instances for the autoscaling group"
}

variable "asg_max" {
  default     = 1
  description = "The maximum number of instances for the autoscaling group"
}

variable "asg_cooldown" {
  default     = "300"
  description = "time between a scaling activity and the succeeding scaling activity"
}

variable "asg_health_check_type" {
  default     = "EC2"
  description = "can be EC2 or ELB"
}

variable "asg_health_grace_period" {
  default     = 600
  description = "How long to wait for instance to come up and start doing health checks"
}

variable "root_volume_type" {
  default     = "gp2"
  description = "can be standard or gp2"
}

variable "root_volume_size" {
  default     = 30
  description = "In gigabytes, must be at least 8"
}

variable "spot-instance-price" {
  default     = ""
  description = "set to blank to use on-demand pricing"
}

variable "inst_type" {
  default     = "t2.small"
  description = "aws instance type"
}

variable "os_version" {
  description = "ami os version"
  default     = "Centos7X86_64"
}

variable "os_release" {
  description = "ami os release"
  default     = "test_ops_latest"
}

variable "ebs_vol_size" {
  description = "size of ebs volume"
  default     = "10"
}
variable "ebs_vol_name" {
  description = "name of ebs volume"
  default     = "/dev/xvdh"
}

variable "ebs_vol_type" {
  description = "type of ebs volume"
  default     = "gp2"
}

variable "efs_to_mount" {
  description = "(Optional) EFS to mount for persistent storage"
  default     = ""
}

variable "force_delete" {
  description = "forcefully delete asg"
  default     = "true"
}

variable "enable_monitoring" {
  description = "enable monitoring of launch configuration"
  default     = "false"
}


variable "associate_public_ip" {
  description = "associate public ip to launch configuration"
  default     = "true"
}

variable "create_before_destroy" {
  description = "lifecycle for asg"
  default     = true
  type        = bool
}

variable "healthcheck_path" {
  default = "/"
}

variable "healthy_threshold" {
  description = "target group healthcheck threshold"
  default     = "2"
}

variable "unhealthy_threshold" {
  description = "target group unheathy healthcheck threshold"
  default     = "2"
}

variable "healthcheck_timeout" {
  default = "30"
}

variable "healthcheck_interval" {
  default = "120"
}

variable "healthcheck_matcher" {
  default = "200"
}

variable "healthcheck_retries" {
  default = 2
}

variable "healthcheck_start_period" {
  default = 120
}

variable "image_id" {
  description = "image id to use for deployment if none is provided a default will be used"
  default     = null
}

variable "stickiness" {
  type = object({
    cookie_duration = number
    enabled         = bool
  })
  description = "target group sticky configuration"
  default     = null
}

variable "user_data_file_path" {
  description = "user data file path"
  default     = null
}

variable "deploy_ec2" {
  description = "feature flag, true or false"
  default     = true
  type        = bool
}