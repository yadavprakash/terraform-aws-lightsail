provider "aws" {
  region = "us-east-1"
}

module "lightsail" {
  source               = "../"
  environment          = "test"
  name                 = "lightsail"
  label_order          = ["name", "environment"]
  public_key           = "ssh-rsa AAAAB3NzaC1yc2EAAAAbCsRRuPV7OGdJuYjJ7Wb1QXgamKRxBIv"
  use_default_key_pair = true
  instance_count       = 1
  user_data            = file("${path.module}/lightsail.sh")

  port_info = [
    {
      port     = 80
      protocol = "tcp"
      cidrs    = ["0.0.0.0/0"]
    },
    {
      port     = 22
      protocol = "tcp"
      cidrs    = ["0.0.0.0/0"]
    }
  ]
}
