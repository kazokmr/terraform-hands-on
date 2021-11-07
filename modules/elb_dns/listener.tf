# ALBへのリクエストの受付設定を行うリスナーの定義
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn  # 割り当てるALBのARN
  port              = "80"            # 受け付けるポート番号
  protocol          = "HTTP"          # 受け付けるプロトコル: ALBはHTTPとHTTPSのみサポート

  # 指定したルールに合致しない場合のデフォルトアクション: ここでは固定レスポンスを返す
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "これは『HTTP』です"
      status_code  = "200"
    }
  }
}

# HTTPSリスナーの定義
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.acm.arn   # ACMで作成した証明書を割り当てる
  ssl_policy        = "ELBSecurityPolicy-2016-08"   # AWS推奨のセキュリティボリシー
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "これは『HTTPS』です"
      status_code  = "200"
    }
  }
}

# HTTP(8080ポート)からHTTPS(443ポート)へリダイレクトするリスナーの定義
resource "aws_lb_listener" "redirect_http_to_https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "8080"
  protocol          = "HTTP"
  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
