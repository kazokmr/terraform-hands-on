#privateサブネットをマルチAZで定義
resource "aws_subnet" "private_0" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.0.65.0/24"
  availability_zone = "ap-northeast-1a"

  # 外部からアクセスさせないので、パブリックIPアドレスは割り当てない
  map_public_ip_on_launch = false
}

resource "aws_subnet" "private_1" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = "10.0.66.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = false
}
