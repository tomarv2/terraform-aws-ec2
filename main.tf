module "global" {
  source = "git::git@github.com:tomarv2/terraform-global.git//aws?ref=v0.0.1"
}

# autoscaling
resource "aws_autoscaling_group" "this" {
  for_each = var.config

  name = each.key

  launch_template {
    id      = join("", [for data in aws_launch_template.this : data.id])
    version = join("", [for data in aws_launch_template.this : data.latest_version])
  }
  min_size                  = try(each.value.min_size, 1)
  max_size                  = try(each.value.max_size, 1)
  desired_capacity          = try(each.value.desired_capacity, 1)
  force_delete              = try(each.value.force_delete, "true")
  health_check_grace_period = try(each.value.health_check_grace_period, 300)
  health_check_type         = try(each.value.health_check_type, "EC2")
  default_cooldown          = try(each.value.default_cooldown, "300")
  vpc_zone_identifier       = module.global.list_of_subnets[local.account_id][local.region]

  dynamic "tag" {
    for_each = merge(var.extra_tags)
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
  lifecycle {
    ignore_changes        = [desired_capacity]
    create_before_destroy = true
  }
}
