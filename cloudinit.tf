# SECTION: 1
data "template_file" "shell-script" {
  template = file(var.user_data_file_path) #file("scripts/userdata.sh")
  vars = {
    APP_TO_INSTALL                          = "${var.teamid}-${var.prjid}"
  }
}

# SECTION: 2
data "template_cloudinit_config" "cloudinit" {
  gzip                                      = false
  base64_encode                             = false
  part {
    content_type                            = "text/x-shellscript"
    content                                 = data.template_file.shell-script.rendered
  }
}
