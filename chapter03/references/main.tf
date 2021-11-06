provider "aws" {
  region = "ap-northeast-1"
}

# Security Groupを定義する
resource "aws_security_group" "example_ec2" {
  name = "example-ec2"

  # inboundルール
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outboundルール (port:0でAll、protocol:-1でAll)
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2インスタンスに作成したSecurity Groupを割り当てる
resource "aws_instance" "example" {
  ami           = "ami-0c3fd0f5d33134a76"
  instance_type = "t3.micro"

  # ここで先ほど作成したSecurityGroupの名前からIDを参照することができる(SGは複数設定できるので配列になっている)
  vpc_security_group_ids = [
    aws_security_group.example_ec2.id
  ]

  user_data = <<EOF
  #!/bin/bash
  yum install -y httpd
  systemctl start httpd.service
  EOF
}

# 作成されたEC2インスタンスのPublic DNSを出力しておけば、後でこのDNSからアクセスしやすい
output "example_public_dns" {
  value = aws_instance.example.public_dns
}