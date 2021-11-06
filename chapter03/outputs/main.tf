provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c3fd0f5d33134a76"
  instance_type = "t3.micro"
}

# この場合apply実行時に作成したEC2インスタンスのIDを出力する
output "example_instance_id" {
  value = aws_instance.example.id
}