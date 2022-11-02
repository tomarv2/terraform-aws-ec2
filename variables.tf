variable "config" {
  description = "Ec2 configuration"
  type        = map(any)
  default     = {}
}
variable "extra_tags" {
  description = "Additional tags to associate"
  type        = map(string)
  default     = {}
}
