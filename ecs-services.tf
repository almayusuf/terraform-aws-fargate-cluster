resource "aws_ecs_service" "wordpress" {
  name            = "wordpress-service"
  cluster         = aws_ecs_cluster.main.arn
  task_definition = aws_ecs_task_definition.wordpress.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = aws_lb_target_group.threetier.arn
    container_name   = "wordpress"
    container_port   = 80
  }
  network_configuration {
    security_groups  = [aws_security_group.threetier_service.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = false
  }

  // ordered_placement_strategy {
  //   type  = "binpack"
  //   field = "cpu"
  // }


}