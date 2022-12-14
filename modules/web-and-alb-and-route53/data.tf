# Use aws_caller_identity and aws_region so you can view AWS Account, User, adn region that terraform is executing under
# This avoids any mistakes with deploying resources into an incorrect account or region
data "aws_caller_identity" "web" {}
data "aws_caller_identity" "route53" {}

#Get Latest Amazon Linux AMI to use for EC2 instances
data "aws_ami" "amazon_linux" {
  provider = aws.web
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

