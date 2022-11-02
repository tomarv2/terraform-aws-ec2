resource "aws_launch_template" "this" {
  for_each = var.config

  name          = try(each.value.name_prefix, each.key)
  name_prefix   = try(each.value.name_prefix, null)
  key_name      = each.value.key_name
  image_id      = each.value.image_id
  instance_type = try(each.value.instance_type, "t2.small")

  iam_instance_profile {
    name = each.value.iam_instance_profile_name
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = try(each.value.security_groups, [])
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = each.key
    }
  }
  user_data = base64encode(join("", [for data in data.template_cloudinit_config.cloudinit : data.rendered]))

  dynamic "block_device_mappings" {
    for_each = each.value.block_device_mappings
    content {
      device_name  = block_device_mappings.key
      no_device    = try(block_device_mappings.value.no_device, null)
      virtual_name = try(block_device_mappings.value.virtual_name, null)

      dynamic "ebs" {
        for_each = flatten([try(block_device_mappings.value.ebs, [])])
        content {
          delete_on_termination = try(ebs.value.delete_on_termination, true)
          encrypted             = try(ebs.value.encrypted, null)
          kms_key_id            = try(ebs.value.kms_key_id, null)
          iops                  = try(ebs.value.iops, null)
          throughput            = try(ebs.value.throughput, null)
          snapshot_id           = try(ebs.value.snapshot_id, null)
          volume_size           = try(ebs.value.volume_size, null)
          volume_type           = try(ebs.value.volume_type, null)
        }
      }
    }
  }
  dynamic "capacity_reservation_specification" {
    for_each = try(each.value.capacity_reservation_specification, [])
    content {
      capacity_reservation_preference = "none"
    }
  }
  dynamic "monitoring" {
    for_each = try(each.value.enable_monitoring, [])
    content {
      enabled = each.value.enable_monitoring
    }
  }
  tags = merge(local.shared_tags, var.extra_tags)
}