module "global" {
  source = "git::git@github.com:tomarv2/terraform-global.git//aws?ref=v0.0.1"
}

locals {
  shared_tags = map(
    "Name", "${var.teamid}-${var.prjid}",
    "team", var.teamid,
    "project", var.prjid
  )
}

locals {
  asg_tags = {
    Name    = "${var.teamid}-${var.prjid}"
    team    = var.teamid
    project = var.prjid
  }
}
