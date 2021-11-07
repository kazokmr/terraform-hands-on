resource "aws_vpc" "example" {

  # IPv4アドレスの範囲を指定
  cidr_block = "10.0.0.0/16"

  # 名前解決を有効にし、VPC内のリソースにPublicDNSホストを自動で割り当てる
  enable_dns_support   = true
  enable_dns_hostnames = true

  # Nameタグを追加
  tags = {
    Name = "example"
  }
}
