resource "aws_lb" "alb" {
  name                       = "terraform"
  load_balancer_type         = "application" # application/network
  internal                   = false         # false:インターネット向け, true: VPC内部向け
  idle_timeout               = 60            # タイムアウト(sec)
  enable_deletion_protection = false         # 削除保護を行うか

  # ALBに割り当てるサブネット
  subnets = var.public_subnets

  # ALBのアクセスログの保存先
  access_logs {
    bucket  = var.alb_log_bucket_id
    enabled = true
  }

  # ALBへのアクセス制御
  security_groups = [
    module.http_sg.security_group_id,
    module.https_sg.security_group_id,
    module.http_redirect_sg.security_group_id,
  ]
}

module "http_sg" {
  source      = "../security_group"
  name        = "http-sg"
  vpc_id      = var.vpc_id
  port        = "80"
  cidr_blocks = ["0.0.0.0/0"]
}

module "https_sg" {
  source      = "../security_group"
  name        = "https-sg"
  vpc_id      = var.vpc_id
  port        = "443"
  cidr_blocks = ["0.0.0.0/0"]
}

# HTTPからのリダイレクトに利用する8080ポートの許可
module "http_redirect_sg" {
  source      = "../security_group"
  name        = "http-redirect-sg"
  vpc_id      = var.vpc_id
  port        = "8080"
  cidr_blocks = ["0.0.0.0/0"]
}

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}
