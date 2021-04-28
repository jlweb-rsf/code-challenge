
# Creating the security groups
resource "aws_security_group" "assignment_public_sg" {
  name        = "assignment_public"
  description = "Allowing Ping, SSH and HTTP accesses for instances in public subnet"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "ping"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Apache"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  depends_on = [module.vpc]

  tags = {
    Name = "assignment_public_sg"
  }
}


# Create the Load Balancer security group to have access to Apache app.
resource "aws_security_group" "assignment_alb_sg" {
  name        = "assignment_lb"
  description = "Grant access to 8080"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow Request to Apache"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  depends_on = [module.vpc]

  tags = {
    Name = "assignment_lb_sg"
  }
}
