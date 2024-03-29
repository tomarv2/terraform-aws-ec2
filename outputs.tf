output "name" {
  description = "The name of the autoscaling group."
  value       = [for asg in aws_autoscaling_group.this : asg.name]
}

output "arn" {
  description = "The arn of the autoscaling group."
  value       = [for asg in aws_autoscaling_group.this : asg.arn]
}

output "launch_configuration_name" {
  description = "The name of the launch configuration."
  value       = [for launchcfg in aws_launch_template.this : launchcfg.name]
}

output "key_name" {
  value       = [for launchcfg in aws_launch_template.this : launchcfg.key_name]
  description = "The key used to create the resources."
}
