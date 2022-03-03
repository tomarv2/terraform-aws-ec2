variable "teamid" {
  description = "Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply'"
  type        = string
}

variable "prjid" {
  description = "Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply'"
  type        = string
}

variable "key_name" {
  description = "The SSH key name (NOTE: key should pre-exist)"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM instance profile"
  type        = string
}

variable "security_groups" {
  description = "Security groups to use"
  default     = []
  type        = list(any)
}

variable "asg_min" {
  default     = 1
  description = "The minimum number of instances for the autoscaling group"
  type        = string
}

variable "asg_desired" {
  default     = 1
  description = "The desired number of instances for the autoscaling group"
  type        = string
}

variable "asg_max" {
  default     = 1
  description = "The maximum number of instances for the autoscaling group"
  type        = string
}

variable "asg_cooldown" {
  default     = "300"
  description = "time between a scaling activity and the succeeding scaling activity"
  type        = string
}

variable "asg_health_check_type" {
  default     = "EC2"
  description = "can be EC2 or ELB"
  type        = string
}

variable "asg_health_grace_period" {
  default     = 600
  description = "How long to wait for instance to come up and start doing health checks"
  type        = number
}

variable "root_volume_type" {
  default     = "gp2"
  description = "can be standard or gp2"
  type        = string
}

variable "root_volume_size" {
  default     = 30
  description = "In gigabytes, must be at least 8"
  type        = number
}

variable "inst_type" {
  default     = "t2.small"
  description = "aws instance type"
  type        = string
}


variable "force_delete" {
  description = "forcefully delete asg"
  default     = "true"
  type        = string
}

variable "enable_monitoring" {
  description = "enable monitoring of launch configuration"
  default     = "false"
  type        = string
}


variable "associate_public_ip" {
  description = "associate public ip to launch configuration"
  default     = "true"
  type        = string
}


variable "image_id" {
  description = "image id to use for deployment if none is provided a default will be used"
  default     = null
  type        = string
}


variable "user_data_file_path" {
  description = "user data file path"
  default     = null
  type        = string
}

variable "deploy_ec2" {
  description = "Feature flag, true or false"
  default     = true
  type        = bool
}
