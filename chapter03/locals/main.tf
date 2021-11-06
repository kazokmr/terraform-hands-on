provider "aws" {
  region = "ap-northeast-1"
}

# localsで指定した変数は実行時にオプション指定での変更が不可
locals {
  example_instance_type = "t3.micro"
}

resource "aws_instance" "example" {
  ami           = "ami-0c3fd0f5d33134a76"
  instance_type = local.example_instance_type
}