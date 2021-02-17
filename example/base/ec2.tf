locals {
  security_group = var.security_groups_to_use != null ? flatten([module.securitygroup.security_group_id, var.security_groups_to_use]) : flatten([module.securitygroup.security_group_id])
}

module "ec2" {
  source                                = "git::git@github.com:tomarv2/terraform-aws-ec2.git?ref=0.0.1"
  email                                 = var.email
  teamid                                = var.teamid
  prjid                                 = var.prjid
  key_name                              = var.key_name
  aws_region                            = var.aws_region
  account_id                            = var.account_id
  iam_instance_profile_to_use           = var.iam_instance_profile_to_use
  profile_to_use                        = var.profile_to_use
  security_groups_to_use                = module.securitygroup.security_group_id
  user_data_file_path                   = var.user_data_file_path
}

module "target_group" {
  source                                = "git::git@github.com:tomarv2/terraform-aws-target-group.git?ref=0.0.1"

  email                                 = var.email
  teamid                                = var.teamid
  prjid                                 = var.prjid
  account_id                            = var.account_id
  profile_to_use                        = var.profile_to_use
  aws_region                            = var.aws_region
}

module "lb" {
  source                                = "git::git@github.com:tomarv2/terraform-aws-lb.git?ref=0.0.1"

  email                                 = var.email
  teamid                                = var.teamid
  prjid                                 = var.prjid
  account_id                            = var.account_id
  profile_to_use                        = var.profile_to_use
  aws_region                            = var.aws_region
  target_group_arn                      = module.target_group.target_group_arn
  security_groups_to_use                = local.security_group
  lb_protocol                           = var.lb_protocol
  lb_port                               = var.lb_port
  healthcheck_path                      = var.healthcheck_path
  alb_ssl_policy                        = var.alb_ssl_policy
  alb_cert_arn                          = var.alb_cert_arn
}

module "securitygroup" {
  source                                = "git::git@github.com:tomarv2/terraform-aws-securitygroup.git?ref=0.0.1"

  email                                 = var.email
  teamid                                = var.teamid
  prjid                                 = var.prjid
  profile_to_use                        = var.profile_to_use
  aws_region                            = var.aws_region
}
