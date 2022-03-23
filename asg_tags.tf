locals {
  asg_tags = {
    Name    = "${var.teamid}-${var.prjid}"
    team    = var.teamid
    project = var.prjid
  }
}
