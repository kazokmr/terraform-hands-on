# Redis用のSecurityグループ
module "redis_sg" {
  source      = "../security_group"
  name        = "redis-sg"
  port        = "6379"
  vpc_id      = var.vpc_id
  cidr_blocks = var.vpc_cidr_blocks
}

resource "aws_elasticache_parameter_group" "redis_parameters" {
  name   = "redis-parameters"
  family = "redis6.x"

  # クラスタモードを無効にするパラメータ
  parameter {
    name  = "cluster-enabled"
    value = "no"
  }
}

resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name = "redis-subnet-group"
  # マルチAZによる自動フェイルオーバーを有効にするためには複数AZのサブネットを設定する
  subnet_ids = [
    var.private_subnet_0_id,
    var.private_subnet_1_id,
  ]
}
