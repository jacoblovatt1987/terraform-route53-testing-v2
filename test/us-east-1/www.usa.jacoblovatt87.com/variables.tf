variable "aws_region" {
    description = "AWS Region to Deploy resources into"
    type = string
    default = "us-east-1"
}

variable "profile_name_web" {
    description = "AWS Profile Name"
    type = string
    default = "HomeLab-AWSAdministratorAccess"
}

variable "profile_name_route53" {
    description = "AWS Profile Name"
    type = string
    default = "SharedServices-AWSAdministratorAccess"
}