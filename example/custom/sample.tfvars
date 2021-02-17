email                       = "demo@demo.com"
profile_to_use              = "default"
key_name                    = "demo_key"
iam_instance_profile_to_use = "arn:aws:iam::123456789012:instance-profile/rumse-ecs-mgmt-role"
security_groups_to_use      = ["sg-1234567"]
aws_region                  = "us-west-2"
account_id                  = "123456789012"
user_data                   = "data.template_cloudinit_config.cloudinit.rendered"
# ------------------------------------------------------------------
# Note: Do not change teamid and prjid once set.
teamid                      = "rumse"
prjid                       = "demo-ecs"

