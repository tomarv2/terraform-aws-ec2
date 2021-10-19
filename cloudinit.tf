locals {
  user_data_file_path = var.user_data_file_path != null ? var.user_data_file_path : "${path.module}/scripts/userdata.sh"
}

# SECTION: 1
data "template_file" "shell_script" {
  template = file(local.user_data_file_path)
  vars = {
    APP_TO_INSTALL = "${var.teamid}-${var.prjid}"
  }
}

# SECTION: 2
data "template_cloudinit_config" "cloudinit" {
  gzip          = false
  base64_encode = false
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.shell_script.rendered
  }
}
