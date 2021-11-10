#RDBインスタンスのサブネットグループを定義: マルチAZ対応で複数AZのサブネットを割り当てる
resource "aws_db_subnet_group" "database_subnet_group" {
  name = "database-subnet-group"
  subnet_ids = [
    var.private_subnet_0_id,
    var.private_subnet_1_id,
  ]
}