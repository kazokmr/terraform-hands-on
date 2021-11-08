# カスタマーマスターキーの作成
resource "aws_kms_key" "customer_master_key" {
  description             = "Example Customer Master Key"
  enable_key_rotation     = true # 自動ローテーションを有効にする(1年ごと）
  is_enabled              = true # カスタマーマスターキーを有効にする
  deletion_window_in_days = 30   # 削除待機期間
}

# カスタマーマスターキーのエイリアスを定義
resource "aws_kms_alias" "cms_alias" {
  name          = "alias/example" # "alias/"プレフィックスは必須
  target_key_id = aws_kms_key.customer_master_key.id
}
