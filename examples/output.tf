output "autoscaling_group_name" {
  description = "The name of the autoscaling group for the EC2 instances."
  value       = module.ec2.autoscaling_group_name
}

output "launch_configuration_name" {
  description = "The name of the launch configuration for the EC2 instances."
  value       = module.ec2.launch_configuration_name
}

output "security_group_id" {
  description = "The ID of the default security group associated with the EC2 instances."
  value       = module.security_group.security_group_id
}

output "key_used" {
  value = module.ec2.key_used
}
