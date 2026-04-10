data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = [var.ami_owner]
}

resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.web_public_a_id
  vpc_security_group_ids = [var.web_sg_id]
  key_name               = var.key_name

  tags = { Name = "Bastion-server" }
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.web_public_b_id
  vpc_security_group_ids = [var.web_sg_id]
  key_name               = var.key_name

  tags = { Name = "Web-VM" }
}

resource "aws_instance" "app" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.app_private_a_id
  vpc_security_group_ids = [var.app_sg_id]
  key_name               = var.key_name

  tags = { Name = "App-VM" }
}

resource "aws_instance" "db" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.db_private_a_id
  vpc_security_group_ids = [var.db_sg_id]
  key_name               = var.key_name

  tags = { Name = "DB-VM" }
}
