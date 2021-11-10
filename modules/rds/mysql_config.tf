# MySQLインスタンスのセキュリティグループを定義
module "mysql_sg" {
  source      = "../security_group"
  name        = "mysql-sg"
  port        = "3306"
  vpc_id      = var.vpc_id
  cidr_blocks = var.vpc_cidr_blocks
}
# DBパラメータグループでMySQLの設定を定義する
resource "aws_db_parameter_group" "mysql_parameters" {
  name   = "mysql-parameters"
  family = "mysql8.0" # DBエンジン名と(メジャー)バージョンを指定

  #MySQLのエンコーディングにUTF8を指定する
  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }
}

# DBオプショングループでMySQLに対するプラグインなどのオプションを定義
resource "aws_db_option_group" "mysql_options" {
  name                 = "mysql-options"
  engine_name          = "mysql"
  major_engine_version = "8.0"

  option {
    option_name = "MARIADB_AUDIT_PLUGIN" # MariaDB監査プラグイン: DBに対するログオンやクエリを記録するプラグイン

  }
}