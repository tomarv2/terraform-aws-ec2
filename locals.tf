locals {
  asg_tags = {
    Name    = "${var.teamid}-${var.prjid}"
    team    = var.teamid
    project = var.prjid
  }

  account_info        = var.account_id != null ? var.account_id : data.aws_caller_identity.current.account_id
  override_aws_region = var.aws_region != null ? var.aws_region : data.aws_region.current.name
}


data "aws_region" "current" {}

data "aws_caller_identity" "current" {}
