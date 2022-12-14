locals {
    all_ports = 0
    http_port = 80
    tcp_protocol = "tcp"
    cidr_all = "0.0.0.0/0"
    all_protocols = "-1"
    HTTP_protocol = "HTTP"
}


#####################################################################################
##### VPC Security Groups #####
resource "aws_security_group" "web" {
  provider = aws.web
  name        = "sg_web_${var.deployment_name}"
  description = "Allow inbound HTTP"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = local.http_port
    to_port     = local.http_port
    protocol    = local.tcp_protocol
    cidr_blocks = [local.cidr_all]
  }

  egress {
    from_port       = local.all_ports
    to_port         = local.all_ports
    protocol        = local.all_protocols
    cidr_blocks     = [local.cidr_all]
    
  }

  # workaround https://github.com/hashicorp/terraform-provider-aws/issues/265
  lifecycle { create_before_destroy = true }
}

resource "aws_security_group" "alb" {
  provider = aws.web
  name        = "sg_alb_${var.deployment_name}"
  description = "Allow inbound HTTP"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = local.http_port
    to_port     = local.http_port
    protocol    = local.tcp_protocol
    cidr_blocks = [local.cidr_all]
  }

  egress {
    from_port       = local.all_ports
    to_port         = local.all_ports
    protocol        = local.all_protocols
    cidr_blocks     = [local.cidr_all]
    
  }
  # workaround https://github.com/hashicorp/terraform-provider-aws/issues/265
  lifecycle { create_before_destroy = true }
}
#####################################################################################

#####################################################################################
##### AWS ALB #####
## Create ALB which targets target group
resource "aws_lb" "alb-test-01" {
  provider = aws.web
  name               = "alb-${var.deployment_name}"
  internal           = false
  load_balancer_type = "application" 
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.publicsubnets
  enable_cross_zone_load_balancing = "true"
  tags = {
        Environment = var.environment
  }
}

#####################################################################################

#####################################################################################
##### Web Server 01 #####
resource "aws_instance" "simple-web-server-default" {
  provider = aws.web
  ami = data.aws_ami.amazon_linux.id
  instance_type = var.web_instance_type
  user_data = templatefile("${path.module}/userdata-httpd.sh", {
    webpage_background_colour = var.webpage_background_colour,
    webpage_name = var.webpage_name,
    webpage_path = var.webpage_path,
    #Required for sed replacement to work
    EC2RG = "$${EC2RG}", EC2AZ = "$${EC2AZ}", EC2ID = "$${EC2ID}"
  })
  vpc_security_group_ids = ["${aws_security_group.web.id}"]
  subnet_id = var.web_subnet_id
  user_data_replace_on_change = true

  tags = {
      Name = "simple-web-server-default-${var.deployment_name}_"
  }
}

## Create Target Group which contains simple web server
resource "aws_lb_target_group" "alb-test-default" {
  provider = aws.web
  name               = "alb-${var.webpage_name}-${var.deployment_name}"
  target_type        = "instance"
  port               = local.http_port
  protocol           = local.HTTP_protocol
  vpc_id             = var.vpc_id
  health_check {
    healthy_threshold   = var.health_check["healthy_threshold"]
    interval            = var.health_check["interval"]
    unhealthy_threshold = var.health_check["unhealthy_threshold"]
    timeout             = var.health_check["timeout"]
    path                = var.health_check["path"]
    port                = var.health_check["port"]
}
}

resource "aws_lb_target_group_attachment" "alb-test-default" {
  provider = aws.web
  target_group_arn = aws_lb_target_group.alb-test-default.arn
  target_id        = aws_instance.simple-web-server-default.id
  port             = var.health_check["port"]
}

### AWS LB Listener
resource "aws_lb_listener" "alb-test-simplehttp-default" {
  provider = aws.web
  load_balancer_arn    = aws_lb.alb-test-01.id
  port                 = var.health_check["port"]
  protocol             = local.HTTP_protocol
  default_action {
  target_group_arn = aws_lb_target_group.alb-test-default.arn
  type             = "forward"
}
}

#####################################################################################
##### Web Server 02 #####
resource "aws_instance" "simple-web-server-secondary" {
  provider = aws.web
  ami = data.aws_ami.amazon_linux.id
  instance_type = var.web_instance_type
  user_data = templatefile("${path.module}/userdata-httpd.sh", {
    webpage_background_colour = var.webpage_background_colour_secondary,
    webpage_name = var.webpage_name_secondary,
    webpage_path = var.webpage_path,
    #Required for sed replacement to work
    EC2RG = "$${EC2RG}", EC2AZ = "$${EC2AZ}", EC2ID = "$${EC2ID}"
  })
  vpc_security_group_ids = ["${aws_security_group.web.id}"]
  subnet_id = var.web_secondary_subnet_id
  user_data_replace_on_change = true

  tags = {
      Name = "simple-web-server-secondary-${var.deployment_name}"
  }
}

## Create Target Group which contains simple web server
resource "aws_lb_target_group" "alb-test-secondary" {
  provider = aws.web
  name               = "alb-test-${var.webpage_name_secondary}-${var.deployment_name}"
  target_type        = "instance"
  port               = local.http_port
  protocol           = local.HTTP_protocol
  vpc_id             = var.vpc_id
  health_check {
    healthy_threshold   = var.health_check["healthy_threshold"]
    interval            = var.health_check["interval"]
    unhealthy_threshold = var.health_check["unhealthy_threshold"]
    timeout             = var.health_check["timeout"]
    path                = var.health_check["path"]
    port                = var.health_check["port"]
}
}

resource "aws_lb_target_group_attachment" "alb-test-secondary" {
  provider = aws.web
  target_group_arn = aws_lb_target_group.alb-test-secondary.arn
  target_id        = aws_instance.simple-web-server-secondary.id
  port             = var.health_check["port"]
}

### AWS LB Listener Rule

resource "aws_lb_listener_rule" "redirect_to_path" {
  provider = aws.web
  listener_arn = aws_lb_listener.alb-test-simplehttp-default.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-test-secondary.arn
  }

  condition {
    path_pattern {
      values = ["/${var.webpage_path}/*"]
    }
  }
}


#####################################################################################