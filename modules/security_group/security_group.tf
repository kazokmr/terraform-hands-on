resource "aws_security_group" "default" {
  name   = var.name
  vpc_id = var.vpc_id
}

# Inboundルールの定義: 変数から渡された条件で設定する
resource "aws_security_group_rule" "ingress" {
  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  protocol          = "tcp"
  cidr_blocks       = var.cidr_blocks
  security_group_id = aws_security_group.default.id
}

# Outboundルールの定義: 全てにアクセス可能とする
resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.default.id
}
