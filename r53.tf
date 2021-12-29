resource "aws_route53_zone" "hz" {
  name = var.hz_name
}

resource "aws_route53_record" "zone_apex" {
  zone_id = aws_route53_zone.hz.zone_id
  name    = aws_route53_zone.hz.name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cdn.domain_name
    zone_id                = aws_cloudfront_distribution.cdn.hosted_zone_id
    evaluate_target_health = false
  }
}
