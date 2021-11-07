# Publicネットワークのルートテーブルを定義
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.example.id
}

# デフォルトルートを指定して、VPCの外への通信をインターネットゲートウェイ経由で流す。
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.example.id
  destination_cidr_block = "0.0.0.0/0"
}

# Publicサブネットとルートテーブルを関連付ける: 関連付けを行わないとデフォルトルートテーブルが使われてしまう。
resource "aws_route_table_association" "public_0" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_0.id
}

resource "aws_route_table_association" "public_1" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_1.id
}
