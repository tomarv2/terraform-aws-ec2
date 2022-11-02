terraform {
  required_version = ">= 1.0.1"
  required_providers {
    aws = {
      version = "~> 4.35"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}
module "common" {
  source = "git::git@github.com:tomarv2/terraform-global.git//common?ref=v0.0.1"
}

module "ec2" {
  source = "../"

  config = {
    demoec4 = {
      key_name                  = "vtomar"
      instance_type             = "t2.medium"
      iam_instance_profile_name = "codebuild-demo-ecs"
      image_id                  = "ami-0d593311db5abb72b"
      security_groups           = ["sg-36333b7a"]
      block_device_mappings = {
        "/dev/xvda" = {
          # Root volume
          no_device = 0
          ebs = {
            delete_on_termination = true
            encrypted             = false
            volume_size           = 30
            volume_type           = "gp2"
          }
        },
        "/dev/sda1" = {
          no_device = 1
          ebs = {
            delete_on_termination = true
            encrypted             = true
            volume_size           = 30
            volume_type           = "gp2"
          }
        }
      }
    }
  }


  #-----------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
