resource "aws_ecs_task_definition" "wordpress" {
  family                   = "threetier"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  container_definitions = jsonencode([
    {
      name      = "wordpress"
      image     = "docker.io/wordpress:latest"
      cpu       = 1024
      memory    = 2048
      essential = true

      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
      environment = [
        {
          name  = "WORDPRESS_DB_HOST"
          value = "${aws_db_instance.threetier.address}"
        },
        {
          name  = "WORDPRESS_DB_USER"
          value = "admin"
        },
        {
          name  = "WORDPRESS_DB_PASSWORD"
          value = "wordpress"
        },
        {
          name  = "WORDPRESS_DB_NAME"
          value = "wordpress"
        },
        {
          name  = "WORDPRESS_DB_PORT"
          value = "3306"
        }
      ]
    }
  ])

  // runtime_platform {
  //   operating_system_family = "LINUX"
  //   cpu_architecture        = "X86_64"
  // }
}