

module "labels" {
  source = "git::https://github.com/opsstation/terraform-aws-labels.git?ref=v1.0.0"

  name        = var.name
  environment = var.environment
  label_order = var.label_order
  repository  = var.repository
  managedby   = var.managedby
  attributes  = var.attributes
}

resource "aws_lightsail_instance" "instance" {
  count             = var.instance_enabled ? var.instance_count : 0
  name              = format("%s%s%s", module.labels.id, "-", (count.index))
  availability_zone = var.availability_zone
  blueprint_id      = var.blueprint_id
  bundle_id         = var.bundle_id
  key_pair_name     = var.key_pair_name == "" && var.use_default_key_pair == false ? "${module.labels.id}-keypair" : var.key_pair_name
  depends_on        = [aws_lightsail_key_pair.instance]
  user_data         = var.user_data
  tags = merge(
    module.labels.tags,
    {

      "Name" = format("%s%s%s", module.labels.id, var.delimiter, (count.index))
    }
  )
}

resource "aws_lightsail_instance_public_ports" "public" {
  instance_name = join("", aws_lightsail_instance.instance[*].name)

  dynamic "port_info" {
    for_each = var.port_info == null ? [] : var.port_info

    content {
      protocol  = port_info.value.protocol
      from_port = port_info.value.port
      to_port   = port_info.value.port
      cidrs     = port_info.value.cidrs

    }
  }
}

resource "aws_lightsail_static_ip_attachment" "instance" {
  count          = var.instance_enabled && var.create_static_ip ? var.instance_count : 0
  static_ip_name = aws_lightsail_static_ip.instance[count.index].id
  instance_name  = aws_lightsail_instance.instance[count.index].id
}

resource "aws_lightsail_static_ip" "instance" {
  count = var.instance_enabled && var.create_static_ip ? var.instance_count : 0
  name  = format("%s-IP%s%s", module.labels.id, "-", (count.index))
}

resource "aws_lightsail_key_pair" "instance" {
  count      = var.instance_enabled && var.key_pair_name == "" && var.use_default_key_pair == false ? 1 : 0
  name       = format("%s-keypair", module.labels.id)
  pgp_key    = var.pgp_key
  public_key = var.public_key == "" ? file(var.key_path) : var.public_key
}

resource "aws_lightsail_domain" "test" {
  count = var.domain_name == "" ? 0 : 1

  domain_name = var.domain_name
}