# Use aws_caller_identity and aws_region so you can view AWS Account, User, adn region that terraform is executing under
# This avoids any mistakes with deploying resources into an incorrect account or region
data "aws_caller_identity" "web" {
    provider = aws.web
}
data "aws_caller_identity" "route53" {
    provider = aws.route53
}

data "aws_region" "web" {
    provider = aws.web
}