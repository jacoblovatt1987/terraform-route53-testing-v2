module "route53_testing" {
    source = "../../../modules/web-and-alb-and-route53"

    deployment_name = "rt-usa"

    vpc_id = "vpc-0eb4dc3c53c4843be"
    web_instance_type = "t2.micro"

    webpage_background_colour = "pink"
    webpage_name = "DEFAULT-RT"
    webpage_path = "path"
    web_subnet_id = "subnet-0cdbb49187a0efc42"

    webpage_background_colour_secondary = "Plum"
    webpage_name_secondary = "SECONDARY-RT"
    web_secondary_subnet_id = "subnet-0f93042abb97cc7d9"

    publicsubnets = ["subnet-0816a05982e2abf88","subnet-07140d534332f1cd6","subnet-04832f386f44aefa4"]

    environment = "HomeLab"

    route53_hosted_zone_id = "Z0507869143C75BQB966P"
    fqdn = "realtime.usa.jacoblovatt87.com"

    providers = {
        aws.web = aws.web
        aws.route53 = aws.route53
    }
}