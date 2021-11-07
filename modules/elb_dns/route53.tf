# 取得済みのルートドメイン
data "aws_route53_zone" "root_domain" {
  name = var.host_zone_name
}

# 取得済みドメインのサブドメインでHostZoneを作成する
resource "aws_route53_zone" "sub_domain" {
  name = "terraform.${var.host_zone_name}"
}

# ルートドメインのNSレコードにサブドメインのNSレコードを登録する
resource "aws_route53_record" "add_ns_records_of_subdomain" {
  zone_id = data.aws_route53_zone.root_domain.id  # 追加するのはルートドメインのホストゾーン
  name    = aws_route53_zone.sub_domain.name      # 追加するNSレコードの名称はサブドメイン名
  type    = "NS"
  records = [
    aws_route53_zone.sub_domain.name_servers[0],
    aws_route53_zone.sub_domain.name_servers[1],
    aws_route53_zone.sub_domain.name_servers[2],
    aws_route53_zone.sub_domain.name_servers[3],
  ]
  ttl     = 300
}

# サブドメインにALBを結びつけるAレコードを追加する
resource "aws_route53_record" "record_alb" {
  zone_id = aws_route53_zone.sub_domain.id
  name    = aws_route53_zone.sub_domain.name
  type    = "A"
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

output "domain_name" {
  value = aws_route53_record.record_alb.name
}
