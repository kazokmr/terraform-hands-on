# ALBを割り当てるVPCのID
variable "vpc_id" {}
# ALBを接続する(public)サブネットIDのリスト
variable "alb_subnets" {
  type = list(string)
}
# ALBのAccessLogを保管するS3バケットのID
variable "alb_log_bucket_id" {}

# ホストゾーン名
variable "host_zone_name" {}
