# elastcacheのレプリケーショングループを定義し、Redisサーバーを作成する
resource "aws_elasticache_replication_group" "redis" {
  replication_group_id       = "redis" # Redisのエンドポイント用識別子
  description                = "redis sample"
  engine                     = "redis"           # ElastiCacheのエンジン:redis or memcached を選択
  engine_version             = "6.x"             # バージョン: redis6系は6.xと指定するらしい
  node_type                  = "cache.m3.medium" # ノード種類を指定(インスタンスタイプ同等)
  port                       = 6379              # ポート番号
  security_group_ids         = [module.redis_sg.security_group_id]
  parameter_group_name       = aws_elasticache_parameter_group.redis_parameters.name
  subnet_group_name          = aws_elasticache_subnet_group.redis_subnet_group.name
  num_cache_clusters         = 3                     # ノード数を指定(Optionで無効にしていると関係ない？)
  automatic_failover_enabled = true                  # MultiAZによる自動フェイルオーバーを有効にする
  snapshot_window            = "09:10-10:10"         # スナップショットの作成時刻[UTC](毎日作成)
  snapshot_retention_limit   = 7                     # スナップショットの保持期間日数
  maintenance_window         = "mon:10:40-mon:11:40" # メンテナンス日時の指定[UTC]
  apply_immediately          = false                 # パラメータ変更の即時反映を無効(無効にするとメンテナンス時に反映する)
}
