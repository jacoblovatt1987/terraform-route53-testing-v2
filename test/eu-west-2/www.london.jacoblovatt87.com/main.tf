module "route53_testing" {
    source = "../../../modules/web-and-alb-and-route53"

    deployment_name = "ldn"

    vpc_id = "vpc-043cb2c7eb6fb78c7"
    web_instance_type = "t2.micro"

    webpage_background_colour = "blue"
    webpage_name = "DEFAULT"
    webpage_path = "path"
    web_subnet_id = "subnet-084758753678737a4"

    webpage_background_colour_secondary = "cyan"
    webpage_name_secondary = "SECONDARY"
    web_secondary_subnet_id = "subnet-06dc8d12cc61b96e7"
    
    publicsubnets = ["subnet-0124aa99fa60c2c83","subnet-0dc3e1ada4719d908","subnet-0d98672eeae536fd3"]

    environment = "HomeLab"

    route53_hosted_zone_id = "Z0507869143C75BQB966P"
    fqdn = "www.london.jacoblovatt87.com"

    providers = {
        aws.web = aws.web
        aws.route53 = aws.route53
    }
}