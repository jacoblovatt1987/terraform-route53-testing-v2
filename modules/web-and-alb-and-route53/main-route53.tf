resource "aws_route53_record" "this" {
  provider = aws.route53

  zone_id = var.route53_hosted_zone_id
  name    = var.fqdn
  type    = "A"
  allow_overwrite = true

  alias {
    name                   = aws_lb.alb-test-01.dns_name
    zone_id                = aws_lb.alb-test-01.zone_id
    evaluate_target_health = true
  }
}