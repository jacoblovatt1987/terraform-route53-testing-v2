terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Providers
provider "aws" {
  region = "${var.aws_region}"
  profile = "${var.profile_name_web}"
  alias = "web"

  assume_role {
    
  }
}

provider "aws" {
  profile = "${var.profile_name_route53}"
  alias = "route53"
}