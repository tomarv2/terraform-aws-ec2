output "autoscaling_group_name" {
  description = "The name of the autoscaling group."
  value = aws_autoscaling_group.asg.name
}

output "autoscaling_group_arn" {
  description = "The name of the autoscaling group."
  value = aws_autoscaling_group.asg.arn
}

output "launch_configuration_name" {
  description = "The name of the launch configuration."
  value = aws_launch_configuration.launchcfg.name
}

output "key_used" {
  value = aws_launch_configuration.launchcfg.key_name
  description = "The key used to create the resources."
}
