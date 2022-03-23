resource "aws_ecs_cluster" "cluster" {
  name = "example-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
