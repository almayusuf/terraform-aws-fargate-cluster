resource "aws_lb_target_group" "threetier" {
  name_prefix          = "3tier-"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = aws_vpc.main.id
  deregistration_delay = 30
  target_type          = "ip"

  // health_check {
  //   enabled             = false
  //   // path                = "/"
  //   // healthy_threshold   = 5
  //   // unhealthy_threshold = 10
  //   // timeout             = 120
  //   // interval            = 180
  //   // protocol            = "HTTP"
  // }
}

resource "aws_lb" "threetier" {
  name_prefix                = "3tier-"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb.id]
  subnets                    = aws_subnet.public.*.id
  enable_deletion_protection = false
  idle_timeout               = 60
  ip_address_type            = "dualstack"
}

resource "aws_lb_listener" "lb_listener_http" {
  load_balancer_arn = aws_lb.threetier.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.threetier.arn
    type             = "forward"
  }
}