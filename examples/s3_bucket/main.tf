provider "aws" {
  region = "ap-northeast-1"
}

module "buckets" {
  source = "../../modules/s3_bucket"
}