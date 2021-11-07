# ALBがリクエストをフォワードする対象となるターゲットグループを定義する
resource "aws_lb_target_group" "target_group" {
  name                 = "tg-ecs"
  target_type          = "ip"                 # ECS fargate用なのでipを指定する
  # ルーティング先：通常はエンドポイント(ECS)はHTTP
  vpc_id               = var.vpc_id
  port                 = 80
  protocol             = "HTTP"
  deregistration_delay = 300    # ターゲットの登録を解除するまでの待機時間(sec)

  health_check {
    path                = "/"               # ヘルスチェックに使用するパス
    healthy_threshold   = 5                 # 正常と判定するまでの実行回数
    unhealthy_threshold = 2                 # 異常と判定するまでの実行回数
    timeout             = 5                 # ヘルスチェックのタイムアウト時間(sec)
    interval            = 30                # ヘルスチェックの実行間隔(sec)
    matcher             = 200               # 正常判定とみなすHTTPステータスコード
    port                = "traffic-port"    # ヘルスチェックで使用するポート(traffic-port指定時は前述のルーティングポート)
    protocol            = "HTTP"            # ヘルスチェックに使用するプロトコル
  }

  # ターゲットグループとALBをECSと同時に作成するとエラーになるので依存関係を設定する
  depends_on = [aws_lb.alb]
}

# ターゲットグループにリクエストをフォワードするリスナールールを定義
resource "aws_lb_listener_rule" "lister_rule_tg" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 100

  # フォワード先とするターゲットグループを指定する
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }

  # フォワード条件はPATHベースで今回は全てのパスを対象にする(他にはホストベースなどがある)
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}