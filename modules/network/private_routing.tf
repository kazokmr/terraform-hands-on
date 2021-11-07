# Privateサブネット用のルートテーブルの定義
# マルチAZに対応するためNATゲートウェイごとにルートテーブルを作成する(NATゲートウェイはインターネットゲートウェイとは異なる)
resource "aws_route_table" "private_0" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "private_1" {
  vpc_id = aws_vpc.vpc.id
}

# Privateサブネットからインターネットへ接続するためにNATゲートウェイを割り当てる
resource "aws_route" "private_0" {
  route_table_id         = aws_route_table.private_0.id
  nat_gateway_id         = aws_nat_gateway.nat_gateway_0.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "private_1" {
  route_table_id         = aws_route_table.private_1.id
  nat_gateway_id         = aws_nat_gateway.nat_gateway_1.id
  destination_cidr_block = "0.0.0.0/0"
}

# ルートテーブルとサブネットを関連付ける
resource "aws_route_table_association" "private_0" {
  route_table_id = aws_route_table.private_0.id
  subnet_id      = aws_subnet.private_0.id
}

resource "aws_route_table_association" "private_1" {
  route_table_id = aws_route_table.private_1.id
  subnet_id      = aws_subnet.private_1.id
}
