# packer.pkr.hcl

packer {
  # Specify required plugins
  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

# Set up a variable for the AWS region (optional)
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

# Amazon EBS (EC2) builder
source "amazon-ebs" "rhel8" {
  region                 = var.aws_region
  
  # Choose the latest RHEL 8 AMI from the official Red Hat owner
  source_ami_filter {
    filters = {
      name                = "RHEL-8*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = ["309956199498"]  # Red Hat's official AWS account (may change over time)
    most_recent = true
  }

  instance_type = "t2.micro"
  
  # Update the SSH username if the official RHEL AMI uses a different default
  ssh_username = "ec2-user"

  # The resulting AMI name
  ami_name     = "my-rhel8-ami-{{timestamp}}"
}

# Define a build block that references the Amazon EBS source
build {
  name    = "rhel8-aws-build"
  sources = ["source.amazon-ebs.rhel8"]

  # Basic shell provisioning
  provisioner "shell" {
    inline = [
      "sudo dnf update -y",
      # Install any other packages you need
      "sudo dnf install -y httpd",
      # (Optional) Enable and start services, configure, etc.
    ]
  }
}
