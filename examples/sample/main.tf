terraform {
  required_version = ">= 1.0.1"
  required_providers {
    aws = {
      version = "~> 3.63"
    }
  }
}

provider "aws" {
  region = var.region
}
module "common" {
  source = "git::git@github.com:tomarv2/terraform-global.git//common?ref=v0.0.1"
}


locals {
  security_group = var.security_groups != null ? flatten([module.security_group.security_group_id, var.security_groups]) : flatten([module.security_group.security_group_id])
}

module "ec2" {
  source = "../../"

  security_groups      = local.security_group
  key_name             = var.key_name
  iam_instance_profile = var.iam_instance_profile

  #-----------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}

module "target_group" {
  source = "git::git@github.com:tomarv2/terraform-aws-target-group.git?ref=v0.0.4"

  deploy_target_group = var.deploy_target_group

  teamid = var.teamid
  prjid  = var.prjid

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

  teamid = var.teamid
  prjid  = var.prjid

  lb_port          = var.lb_port
  target_group_arn = module.target_group.target_group_arn
  security_groups  = local.security_group
  lb_type          = var.lb_type
  lb_protocol      = var.lb_protocol
  alb_cert_arn     = var.alb_cert_arn
  alb_ssl_policy   = var.alb_ssl_policy
}
module "security_group" {
  source = "git::git@github.com:tomarv2/terraform-aws-security-group.git?ref=v0.0.5"

  deploy_security_group = var.deploy_security_group


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
