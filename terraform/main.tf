terraform {
  required_providers {
    linode = {
      source = "linode/linode"
    }
  }
  backend "s3" {
    endpoints = {
      s3 = "s3.us-west-004.backblazeb2.com"
    }
    access_key = var.b2_application_key_id //B2 keyID
    secret_key = var.b2_application_key    //B2 applicationKey
    bucket     = "earles-tfstate"
    key        = "terraform_bedrock.tfstate"
    region     = "us-west-004"

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_s3_checksum            = true
  }
}

variable "b2_application_key_id" {}
variable "b2_application_key" {}
variable "linode_token" {}
variable "authorized_users" {}
# variable "username" {}
# variable "tailscale_auth_key" {}

provider "linode" {
  token = var.linode_token
}

resource "linode_instance" "instance" {
  label = "bedrock"
  image = "linode/ubuntu24.04"
  # stackscript_id  = var.stackscript_id != "" ? var.stackscript_id : null
  region           = "us-lax"
  type             = "g6-nanode-1"
  authorized_users = var.authorized_users
  metadata {
    user_data = base64encode(templatefile("cloud-init.tftpl"))
    # user_data = base64encode(templatefile("cloud-init.tftpl", {tailscale_auth_key = var.tailscale_auth_key}))
  }
}

output "instance_ip" {
  value = linode_instance.instance.ip_address
}

# Add cloudflare DNS entry resource
# Install Docker
# Git clone docker-compose.yml
# Figure out how to pull and start containers
# Figure out how to configure mcxboxbroadcast config.yml