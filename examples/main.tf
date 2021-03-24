locals {
  security_group = var.security_groups_to_use != null ? flatten([module.security_group.security_group_id, var.security_groups_to_use]) : flatten([module.security_group.security_group_id])
}

module "ec2" {
  source = "../"

  security_groups_to_use      = module.security_group.security_group_id
  key_name                    = "demo_key"
  iam_instance_profile_to_use = "arn:aws:iam::123456789012:instance-profile/rumse-demo-role"
  account_id                  = "123456789012"
  #-----------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}

module "target_group" {
  source = "git::git@github.com:tomarv2/terraform-aws-target-group.git?ref=v0.0.1"

  teamid     = var.teamid
  prjid      = var.prjid
  account_id = "123456789012"
}

module "lb" {
  source = "git::git@github.com:tomarv2/terraform-aws-lb.git?ref=v0.0.1"

  teamid     = var.teamid
  prjid      = var.prjid
  account_id = "123456789012"

  target_group_arn       = module.target_group.target_group_arn
  security_groups_to_use = local.security_group
}

module "security_group" {
  source = "git::git@github.com:tomarv2/terraform-aws-security-group.git?ref=v0.0.1"

  teamid = var.teamid
  prjid  = var.prjid
}
