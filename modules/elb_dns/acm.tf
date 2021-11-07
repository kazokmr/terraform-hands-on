# サーバー証明書を定義する
resource "aws_acm_certificate" "acm" {
  domain_name               = "*.${aws_route53_zone.sub_domain.name}"   # サブドメインに対するワイルドカード証明書とする
  subject_alternative_names = [aws_route53_zone.sub_domain.name]        # 代替ドメインはサブドメイン自身
  validation_method         = "DNS"                                     # 検証方法はDNS/EMAILが選べる。自動更新させるならDNS
  lifecycle {
    create_before_destroy = true                                        # 新しい証明書を作成してから古い証明書と差し替える
  }
}

# DNSによる証明書の検証を実施
resource "aws_route53_record" "validation_acm" {
  for_each        = {
  for dvo in aws_acm_certificate.acm.domain_validation_options : dvo.domain_name => {
    name   = dvo.resource_record_name
    record = dvo.resource_record_value
    type   = dvo.resource_record_type
  }
  }
  allow_overwrite = true
  name            = each.value.name
  type            = each.value.type
  records         = [each.value.record]
  zone_id         = aws_route53_zone.sub_domain.zone_id
  ttl             = 300
}

# 検証完了まで待機
resource "aws_acm_certificate_validation" "wait_validation" {
  certificate_arn         = aws_acm_certificate.acm.arn
  validation_record_fqdns = [for record in aws_route53_record.validation_acm :record.fqdn]
}
