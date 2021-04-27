# Creating the application load balancer.
resource "aws_alb" "assignment_alb" {
  name               = "apache-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.assignment_alb_sg.id]

  subnet_mapping {
    subnet_id     = module.public_subnets.az_subnet_ids[var.availability_zones[0]]
  }

  subnet_mapping {
    subnet_id     = module.public_subnets.az_subnet_ids[var.availability_zones[1]]
  }

  tags = {
    Name = "assignment_alb"
  }
}

# Creating LB target group.
resource "aws_alb_target_group" "apache_alb_tg" {
  name     = "apache-lb-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    interval            = 30
    path                = "/"
    port                = 8080
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  target_type = "instance"

  tags = {
    Name = "apache-lb-tg"
  }
}

# Define the listener port of created LB.
resource "aws_alb_listener" "apache" {
  load_balancer_arn = aws_alb.assignment_alb.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.apache_alb_tg.arn
  }
}

# Register EC2 instance to the created LB as target group.
resource "aws_alb_target_group_attachment" "apache_targets" {
  target_group_arn = aws_alb_target_group.apache_alb_tg.arn
  target_id        = aws_instance.apache_server.id
  port             = 8080
}


#Creating a launch template with the same configuration as launched EC2 instance.
resource "aws_launch_template" "assignment" {
  name_prefix            = "assignment-"
  image_id               = var.aws_ec2_ami[var.aws_region]
  instance_type          = var.aws_ec2_instance_type
  key_name               = var.ssh_private_key_name
  vpc_security_group_ids = [aws_security_group.assignment_private_sg.id]



  network_interfaces {
    associate_public_ip_address = false
  }
}

