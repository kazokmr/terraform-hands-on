# MySQLデータベースインスタンスを定義
resource "aws_db_instance" "mysql" {
  identifier                 = "mysql"       # DBインスタンスのID(エンドポイントのサブドメインになる)
  engine                     = "mysql"       # DBエンジン名
  engine_version             = "8.0.25"      # DBバージョン
  instance_class             = "db.t3.small" # RDSインスタンスタイプ
  port                       = 3306          # ポート番号
  multi_az                   = true          # マルチAZを有効
  publicly_accessible        = false         # パブリックアクセスを無効
  vpc_security_group_ids     = [module.mysql_sg.security_group_id]
  db_subnet_group_name       = aws_db_subnet_group.database_subnet_group.name
  parameter_group_name       = aws_db_parameter_group.mysql_parameters.name
  option_group_name          = aws_db_option_group.mysql_options.name
  storage_type               = "gp2"                 # ストレージタイプ gp2:汎用SSD
  allocated_storage          = 20                    # 初期ストレージサイズ
  max_allocated_storage      = 100                   # 最大ストレージサイズ
  storage_encrypted          = true                  # ディスク暗号化
  kms_key_id                 = var.kms_key_arn       # KMSの鍵を指定しディスクを暗号化する
  username                   = "admin"               # マスターユーザー
  password                   = var.database_password # マスターパスワード
  backup_window              = "09:10-09:40"         # バックアップの実施時刻[UTC]
  backup_retention_period    = 30                    # バックアップ期間(最大35日)
  maintenance_window         = "mon:10:10-mon:10:40" # メンテナンス実施日時[UTC]
  auto_minor_version_upgrade = false                 # マイナーバージョンの自動アップデートを無効
  apply_immediately          = false                 # 設定変更の即時反映を無効(無効の場合はメンテナンス実施時)
  deletion_protection        = false                 # インスタンスの削除保護を無効化(通常は有効。これはデモなので削除可にした)
  skip_final_snapshot        = true                  # インスタンス削除時のスナップショット取得をスキップ

  lifecycle {
    # Terraformでマスターパスワードの変更を追従しない > AWS側でパスワードを変更しても無視するようになる > インスタンス作成後にパスワードが変更できる
    ignore_changes = [password]
  }
}