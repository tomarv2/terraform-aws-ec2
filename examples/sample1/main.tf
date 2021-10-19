provider "aws" {
  region  = var.aws_region
  profile = var.profile_to_use
}
module "common" {
  source = "git::git@github.com:tomarv2/terraform-global.git//common?ref=v0.0.1"
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

locals {
  security_group      = var.security_groups_to_use != null ? flatten([module.security_group.security_group_id, var.security_groups_to_use]) : flatten([module.security_group.security_group_id])
  account_info        = var.account_id != null ? var.account_id : data.aws_caller_identity.current.account_id
  override_aws_region = var.aws_region != null ? var.aws_region : data.aws_region.current.name
}

module "ec2" {
  source = "../../"

  security_groups_to_use      = local.security_group
  key_name                    = var.key_name
  iam_instance_profile_to_use = var.iam_instance_profile_to_use
  account_id                  = local.account_info
  #-----------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}

module "target_group" {
  source = "git::git@github.com:tomarv2/terraform-aws-target-group.git?ref=v0.0.4"

  deploy_target_group = var.deploy_target_group

  teamid               = var.teamid
  prjid                = var.prjid
  account_id           = local.account_info
  aws_region           = local.override_aws_region
  lb_protocol          = var.target_group_protocol != null ? var.target_group_protocol : var.lb_protocol
  lb_port              = var.target_group_port != null ? var.target_group_port : var.lb_port
  healthcheck_path     = var.healthcheck_path
  healthy_threshold    = var.healthy_threshold
  healthcheck_matcher  = var.healthcheck_matcher
  healthcheck_timeout  = var.healthcheck_timeout
  unhealthy_threshold  = var.unhealthy_threshold
  healthcheck_interval = var.healthcheck_interval
  target_type          = "instance"
}


module "lb" {
  source = "git::git@github.com:tomarv2/terraform-aws-lb.git?ref=v0.0.5"

  deploy_lb = var.deploy_lb

  teamid                 = var.teamid
  prjid                  = var.prjid
  account_id             = local.account_info
  aws_region             = local.override_aws_region
  lb_port                = var.lb_port
  target_group_arn       = module.target_group.target_group_arn
  security_groups_to_use = local.security_group
  lb_type                = var.lb_type
  lb_protocol            = var.lb_protocol
  alb_cert_arn           = var.alb_cert_arn
  alb_ssl_policy         = var.alb_ssl_policy
}
module "security_group" {
  source = "git::git@github.com:tomarv2/terraform-aws-security-group.git?ref=v0.0.5"

  deploy_security_group = var.deploy_security_group

  account_id = local.account_info
  aws_region = local.override_aws_region
  security_group_ingress = {
    default = {
      description = "https"
      type        = "ingress"
      from_port   = 443
      protocol    = "tcp"
      to_port     = 443
      self        = true
      cidr_blocks = []
    },
    ssh = {
      description = "ssh"
      from_port   = 22
      type        = "ingress"
      protocol    = "tcp"
      to_port     = 22
      self        = false
      cidr_blocks = module.common.cidr_for_sec_grp_access
    }
  }
  #-----------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
