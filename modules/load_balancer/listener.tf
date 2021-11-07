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