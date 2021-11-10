# Clusterモード有効時のエンドポイント
output "redis_configuration_endpoint" {
  value = module.redis.configuration_endpoint
}

# Clusterモード無効時のエンドポイント
output "redis_non_cluster_primary_endpoint" {
  value = module.redis.non_cluster_primary_endpoint
}

# Clusterモード無効時の読み込みエンドポイント
output "redis_non_cluster_reader_endpoint" {
  value = module.redis.non_cluster_reader_endpoint
}

# ポート番号
output "redis_port" {
  value = module.redis.port
}
