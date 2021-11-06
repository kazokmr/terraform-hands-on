provider "aws" {
  region = "ap-northeast-1"
}

# モジュールのソースを指定し、変数に値を代入する
module "web_server" {
  source        = "./http_server"
  instance_type = "t3.micro"
}

# モジュールで作成したEC2のDNSを出力する
output "public_dns" {
  value = module.web_server.public_dns
}