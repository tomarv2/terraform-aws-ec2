locals {
  imageid = var.image_id != null ? var.image_id : module.global.ec2_ami[var.account_id][var.aws_region]
  # TODO: check this again
  security_group = var.security_groups_to_use #!= null ? flatten([module.securitygroup.security_group_id, var.security_groups_to_use]) : flatten([module.securitygroup.security_group_id])
}

# autoscaling
resource "aws_autoscaling_group" "asg" {
  name                      = "${var.teamid}-${var.prjid}"
  launch_configuration      = aws_launch_configuration.launchcfg.name
  min_size                  = var.asg_min
  max_size                  = var.asg_max
  desired_capacity          = var.asg_desired
  force_delete              = var.force_delete
  health_check_grace_period = var.asg_health_grace_period
  health_check_type         = var.asg_health_check_type
  default_cooldown          = var.asg_cooldown
  vpc_zone_identifier       = module.global.list_of_subnets[var.account_id][var.aws_region]

  dynamic "tag" {
    for_each = local.asg_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

# launch config
resource "aws_launch_configuration" "launchcfg" {
  name                        = "${var.teamid}-${var.prjid}"
  key_name                    = var.key_name
  image_id                    = local.imageid
  instance_type               = var.inst_type
  iam_instance_profile        = var.iam_instance_profile_to_use
  enable_monitoring           = var.enable_monitoring
  security_groups             = flatten([var.security_groups_to_use])
  associate_public_ip_address = var.associate_public_ip
  user_data                   = data.template_cloudinit_config.cloudinit.rendered

  root_block_device {
    volume_type = var.root_volume_type
    volume_size = var.root_volume_size
  }

  lifecycle {
    create_before_destroy = true # cannot be parameterize
  }
}