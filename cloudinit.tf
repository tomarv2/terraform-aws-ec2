# SECTION: 1
data "template_file" "shell_script" {
  for_each = var.config

  template = file(try(each.value.user_data_file_path, null) != null ? each.value.user_data_file_path : "${path.module}/scripts/userdata.sh")
  vars = {
    APP_TO_INSTALL = each.key
  }
}

# SECTION: 2
data "template_cloudinit_config" "cloudinit" {
  for_each = data.template_file.shell_script

  gzip          = false
  base64_encode = false
  part {
    content_type = "text/x-shellscript"
    content      = join("", [for data in data.template_file.shell_script : data.rendered])
  }
}
