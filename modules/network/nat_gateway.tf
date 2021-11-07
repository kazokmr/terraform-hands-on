# privateサブネットからインターネットへアクセスするためのNATゲートウェイを定義する:depends_onでインターネットゲートウェイ作成後に実行させる
# マルチAZ化にあたりNATゲートウェイを複数のPublicサブネットに割り当てるために冗長化する

# NATゲートウェイに割り当てるEIPを用意する
resource "aws_eip" "nat_gateway_0" {
  vpc        = true
  depends_on = [aws_internet_gateway.internet_gateway]
}

resource "aws_eip" "nat_gateway_1" {
  vpc        = true
  depends_on = [aws_internet_gateway.internet_gateway]
}

# NATゲートウェイをパブリックサブネットに配置し、EIPを指定する:Publicサブネットにしているのは外に出るため
resource "aws_nat_gateway" "nat_gateway_0" {
  subnet_id     = aws_subnet.public_0.id
  allocation_id = aws_eip.nat_gateway_0.id
  depends_on    = [aws_internet_gateway.internet_gateway]
}

resource "aws_nat_gateway" "nat_gateway_1" {
  subnet_id     = aws_subnet.public_1.id
  allocation_id = aws_eip.nat_gateway_1.id
  depends_on    = [aws_internet_gateway.internet_gateway]
}