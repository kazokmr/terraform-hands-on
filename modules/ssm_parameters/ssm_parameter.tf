# DBユーザー名
resource "aws_ssm_parameter" "db_username" {
  name        = "/db/username"
  value       = var.db_username
  type        = "String" # Valueを平文で保管する
  description = "データベースのユーザー名"
}

# DBパスワード：パラメータの初回登録用。後からAWSで変更すること
resource "aws_ssm_parameter" "db_password" {
  name        = "/db/password"
  value       = var.db_initial_password
  type        = "SecureString"
  description = "データベースのパスワード"

  lifecycle {
    # valueの変更を無視することで、この後Terraformでパスワードを変更しても無視される。
    # つまりTerraformで初回登録をした後、すぐにAWSで直接パスワードを更新すれば、Terraformのコード上でパスワードの閲覧も更新もできなくなる
    ignore_changes = [value]
  }
}

# sample: DBのパスワードをSSMパラメータで暗号化して保存する > とはいえこのままだと、このファイル上には平文で残るので意味がない
#resource "aws_ssm_parameter" "db_raw_password" {
#  name        = "/db/raw_password"
#  value       = "VeryStrongPassword!"
#  type        = "SecureString"              # Valueを暗号化して保管する
#  description = "データベースのパスワード"
#}
