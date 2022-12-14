output "web_account_id" {
  value = "${data.aws_caller_identity.web.account_id}"
}

output "web_caller_arn" {
  value = "${data.aws_caller_identity.web.arn}"
}

output "web_caller_user_id" {
  value = "${data.aws_caller_identity.web.id}"
}

output "web_caller_user" {
  value = "${data.aws_caller_identity.web.user_id}"
}

output "web_aws_region" {
  value = "${data.aws_region.web.name}"
}



output "route53_account_id" {
  value = "${data.aws_caller_identity.route53.account_id}"
}

output "route53_caller_arn" {
  value = "${data.aws_caller_identity.route53.arn}"
}

output "route53_caller_user_id" {
  value = "${data.aws_caller_identity.route53.id}"
}

output "route53_caller_user" {
  value = "${data.aws_caller_identity.route53.user_id}"
}

output alb_dns_name {
    value = module.route53_testing.alb_dns_name
}

output "route53-dns-fqdn" {
    value = module.route53_testing.route53-dns-fqdn
}

output "route53-dns-alias" {
    value = module.route53_testing.route53-dns-alias
}