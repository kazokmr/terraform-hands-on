resource "aws_ecs_task_definition" "batch_task" {
  family                   = "batch"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file(var.batch_container_definitions_path)
  execution_role_arn       = var.ecs_task_execution_iam_role_arn
}
