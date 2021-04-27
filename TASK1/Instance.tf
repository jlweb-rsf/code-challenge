
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "aws_key" {
  key_name   = "assginment-ssh-key"
  public_key = tls_private_key.key.public_key_openssh
}

resource "aws_instance" "apache_server" {
  ami                         = var.aws_ec2_ami[var.aws_region]
  instance_type               = var.aws_ec2_instance_type
  key_name                    = aws_key_pair.aws_key.key_name
  subnet_id                   = module.public_subnets.az_subnet_ids[var.availability_zones[0]]
  vpc_security_group_ids      = [aws_security_group.assignment_private_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "assignment_apache_server"
  }
}

