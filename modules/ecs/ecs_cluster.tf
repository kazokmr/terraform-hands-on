# ECSクラスタの定義: Dockerコンテナタスクを束ねるもの
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "ecs-cluster"
}