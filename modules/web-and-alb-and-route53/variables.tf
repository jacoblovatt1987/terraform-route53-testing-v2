
variable "vpc_id" {
    description = "VPC ID for Deployment"
    type = string
}

variable "web_instance_type" {
    description = "Instance Type for the Web Server"
    type = string
    default = "t2.micro"
}

variable "webpage_background_colour" {
    description = "Colour of Background for Web Page"
    type = string
    default = "blue"
}

variable "webpage_name" {
    description = "Name for Web Page"
    type = string
    default = "DEFAULT"
}

variable "webpage_path" {
    description = "Path for Web Page"
    type = string
    default = "path"
}

variable "webpage_background_colour_secondary" {
    description = "Colour of Background for Web Page - Secondary Server"
    type = string
    default = "cyan"
}

variable "webpage_name_secondary" {
    description = "Name for Web Page - Secondary Server"
    type = string
    default = "SECONDARY"
}

variable "web_subnet_id" {
    description = "Subnet for Web Server"
    type = string
}

variable "web_secondary_subnet_id" {
    description = "Subnet for Web Server"
    type = string
}

variable "health_check" {
   type = map(string)
   default = {
      "timeout"  = "10"
      "interval" = "20"
      "path"     = "/"
      "port"     = "80"
      "unhealthy_threshold" = "2"
      "healthy_threshold" = "3"
    }
}

variable publicsubnets {
    type = list
}

variable "environment" {
    description = "Environment Tag"
    type = string
}

variable "route53_hosted_zone_id" {
    description = "Route53 Hosted Zone ID"
    type = string
}

variable "fqdn" {
    description = "Route53 FQDN for Web Service"
    type = string
}

variable "deployment_name" {
    description = "Unique deployment name"
    type = string
}