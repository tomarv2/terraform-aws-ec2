//terraform {
//  required_version            = ">= 0.14"
//  required_providers {
//    aws = {
//      version                     = "~> 2.61"
//    }
//  }
//}

provider "aws" {
  region                      = var.aws_region
  profile                     = var.profile_to_use
}

module "global" {
    source                    = "git::git@github.com:tomarv2/terraform-global.git//aws?ref=0.0.1"
}

locals {
  shared_tags  = map(
      "Name", "${var.teamid}-${var.prjid}",
      "Owner", var.email,
      "Team", var.teamid,
      "Project", var.prjid
  )
}

locals {
  asg_tags = {
      Name                    = "${var.teamid}-${var.prjid}"
      Owner                   = var.email
      Team                    = var.teamid
      Project                 = var.prjid
  }
}
