output alb_dns_name {
    value = aws_lb.alb-test-01.dns_name
}

output "route53-dns-fqdn" {
    value = aws_route53_record.this.fqdn
}

output "route53-dns-alias" {
    value = aws_route53_record.this.alias
}