variable "teamid" {
  description = "Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply'"
  type        = string
}

variable "prjid" {
  description = "Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply'"
  type        = string
}

variable "security_groups" {
  description = "Security groups to use"
  default     = []
  type        = list(any)
}

variable "deploy_security_group" {
  description = "Feature flag, true or false"
  default     = true
  type        = bool
}

variable "deploy_target_group" {
  description = "Feature flag, true or false"
  default     = true
  type        = bool
}

variable "target_group_protocol" {
  description = "type of load balancer (e.g. HTTP, TCP, etc)"
  default     = null
  type        = string
}

variable "target_group_port" {
  description = "target group ports"
  default     = null
  type        = list(number)
}


variable "healthcheck_path" {
  description = "target group healthcheck path"
  default     = ""
  type        = string
}

variable "healthy_threshold" {
  description = "target group healthcheck threshold"
  default     = ""
  type        = string
}

variable "healthcheck_matcher" {
  description = "healthcheck matcher (e.g. 200)"
  default     = ""
  type        = string
}

variable "healthcheck_timeout" {
  description = "target group healthcheck timeout"
  default     = ""
  type        = string
}

variable "healthcheck_interval" {
  description = "target group healthcheck interval"
  default     = ""
  type        = string
}

variable "unhealthy_threshold" {
  description = "target group unheathy healthcheck threshold"
  default     = ""
  type        = string
}

variable "deploy_lb" {
  description = "Feature flag, true or false"
  default     = true
  type        = bool
}

variable "lb_port" {
  description = "Load balancer type"
  default     = [80]
  type        = list(any)
}

variable "lb_type" {
  description = "load balancer type (network or application"
  default     = "application"
  type        = string
}

variable "lb_protocol" {
  description = "type of load balancer (e.g. HTTP, TCP, etc)"
  default     = "HTTP"
  type        = string
}

variable "alb_ssl_policy" {
  description = "alb ssl policy"
  default     = ""
  type        = string
}

variable "alb_cert_arn" {
  description = "alb cert arn"
  default     = ""
  type        = string
}

variable "key_name" {
  type        = string
  description = "aws ssh key name"
}

variable "iam_instance_profile" {
  type        = string
  description = "iam instance profile"
}

variable "region" {
  description = "AWS region to create resources"
  default     = "us-west-2"
  type        = string
}
