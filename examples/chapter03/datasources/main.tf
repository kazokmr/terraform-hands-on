provider "aws" {
  region = "ap-northeast-1"
}

# amazon_linux2の最新安定版AMIを絞り込み検索
data "aws_ami" "recent_amazon_linux2" {

  # amazonがownersの最新AMI
  most_recent = true
  owners      = ["amazon"]

  # 名前が以下のようなAMI (これがAmazon Linux2の標準AMIの名称?にはDateがyyyymmddの8桁で入ることを意味する正規表現)
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.????????-x86_64-gp2"]
  }

  # 状態が利用可能なもの
  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.recent_amazon_linux2.image_id
  instance_type = "t3.micro"
}