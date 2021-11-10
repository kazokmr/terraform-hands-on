# Clusterモード有効時のエンドポイント
output "configuration_endpoint" {
  value = aws_elasticache_replication_group.redis.configuration_endpoint_address
}

# Clusterモード無効時のエンドポイント
output "non_cluster_primary_endpoint" {
  value = aws_elasticache_replication_group.redis.primary_endpoint_address
}

# Clusterモード無効時の読み込みエンドポイント
output "non_cluster_reader_endpoint" {
  value = aws_elasticache_replication_group.redis.reader_endpoint_address
}

# ポート番号
output "port" {
  value = aws_elasticache_replication_group.redis.port
}
