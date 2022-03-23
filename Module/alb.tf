resource "aws_lb_target_group" "test" {
  name        = "tf-example-lb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = module.vpc.id
  target_type = "ip"
<<<<<<< HEAD
  deregistration_delay = 30
  // health_check {
  //  healthy_threshold   = "10"
  //  interval            = "120"
  //  protocol            = "HTTP"
  //  matcher             = "200"
  //  timeout             = "119"
  // //  path                = var.health_check_path
  // //  unhealthy_threshold = "2"
=======
  // health_check {
  //   enabled             = true
  //   path                = "/"
  //   healthy_threshold   = 3
  //   unhealthy_threshold = 3
  //   timeout             = 30
  //   interval            = 60
  //   protocol            = "HTTP"
>>>>>>> 7596bce40730e7b0e2ea891191dc64d58a1ea8db
  // }
}

resource "aws_lb" "test" {
  name                       = "three-tier"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [module.web_server_sg.id]
  subnets                    = module.vpc.public_subnets
  enable_deletion_protection = false
}

resource "aws_lb_listener" "lb_listener_http" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.test.arn
    type             = "forward"
  }
}

