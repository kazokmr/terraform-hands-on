provider "aws" {
  region = "ap-northeast-1"
}

# variableで定義した変数は実行時に-varオプションを付けて変更できる `terraform plan -var 'example_instance_type=t3.nano'`
variable "example_instance_type" {
  default = "t3.micro"
}

resource "aws_instance" "example" {
  ami           = "ami-0c3fd0f5d33134a76"
  instance_type = var.example_instance_type
}