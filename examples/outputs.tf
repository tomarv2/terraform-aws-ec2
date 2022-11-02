output "name" {
  description = "The name of the autoscaling group."
  value       = module.ec2.name
}

output "arn" {
  description = "The arn of the autoscaling group."
  value       = module.ec2.arn
}

output "launch_configuration_name" {
  description = "The name of the launch configuration."
  value       = module.ec2.launch_configuration_name
}

output "key_name" {
  description = "The key used to create the resources."
  value       = module.ec2.key_name
}
