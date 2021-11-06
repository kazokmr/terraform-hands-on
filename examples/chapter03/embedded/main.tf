provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c3fd0f5d33134a76"
  instance_type = "t3.micro"

  # file関数を使って外部ファイルを読み込ませる
  user_data = file("./user_data.sh")
}