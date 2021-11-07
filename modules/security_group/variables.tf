# Security Groupの名前
variable "name" {}
# Security Groupを割り当てるVPC
variable "vpc_id" {}
# 通信を許可するポート
variable "port" {}
# 許可するIPv4アドレスをCIDR BLOCKのアドレスリスト
variable "cidr_blocks" {
  type = list(string)
}
