variable "email" {
  description = "email address to be used for tagging (suggestion: use group email address)"
}

variable "teamid" {
  description = "(Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply'"
}

variable "prjid" {
  description = "(Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply'"
}

variable "key_name" {
  description = "The SSH key name (NOTE: key should pre-exist)"
}

variable "profile_to_use" {
  description = "Getting values from ~/.aws/credentials"
}

variable "iam_instance_profile_to_use" {
  description = "IAM instance profile"
}

variable "aws_region" {
  description = "The AWS region to create resources"
  default     = "us-west-2"
}

variable "account_id" {}

variable "lb_port" {
  default = [80]
}

variable "user_data_file_path" {
  description = "user data file path"
  default = "scripts/userdata.sh"
}

# target group
variable "enable_monitoring" {
  default     = "false"
}

variable "create_before_destroy" {
  default     = true
  type        = bool
}

variable "healthcheck_path" {
  default     = "/"
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
  default     = "30"
}

variable "healthcheck_interval" {
  default     = "120"
}

variable "healthcheck_matcher" {
  default     = "200"
}

variable "healthcheck_retries" {
  default = 2
}

variable "healthcheck_start_period" {
  default = 120
}

variable "is_public" {
  description = "is the resource public"
  default     = "false"
}

variable "lb_type" {
  description = "load balancer type (network or application"
  default     = "application"
}

variable "lb_protocol" {
  default     = "HTTP"
}

variable "alb_cert_arn" {
    default     = ""
}

variable "alb_ssl_policy" {
  default     = ""
}

variable "alb_action_type" {
  default     = "forward"
}

variable "stickiness" {
  type = object({
    cookie_duration = number
    enabled         = bool
  })
  description = "Target group sticky configuration"
  default     = null
}

variable "security_groups_to_use" {
  description = "Existing Security groups to use"
  default = null
}