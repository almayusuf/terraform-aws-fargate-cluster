# Security Group for ALB
resource "aws_security_group" "alb" {
  name_prefix = "threetier-alb"
  vpc_id      = aws_vpc.main.id
}


resource "aws_security_group_rule" "threetier_alb_allow_80" {
  security_group_id = aws_security_group.alb.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  description       = "Allow HTTP traffic."
}

resource "aws_security_group_rule" "threetier_alb_allow_outbound" {
  security_group_id = aws_security_group.alb.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  description       = "Allow any outbound traffic."
}

# Security Group for Threetier Service.
resource "aws_security_group" "threetier_service" {
  name_prefix = "threetier-service"
  vpc_id      = aws_vpc.main.id
}

resource "aws_security_group_rule" "threetier_service_allow_80" {
  security_group_id        = aws_security_group.threetier_service.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 80
  to_port                  = 80
  source_security_group_id = aws_security_group.alb.id
  description              = "Allow incoming traffic from the ALB into the service container port."
}

resource "aws_security_group_rule" "threetier_service_allow_inbound_self" {
  security_group_id = aws_security_group.threetier_service.id
  type              = "ingress"
  protocol          = -1
  self              = true
  from_port         = 0
  to_port           = 0
  description       = "Allow traffic from resources with this security group."
}

resource "aws_security_group_rule" "threetier_service_allow_outbound" {
  security_group_id = aws_security_group.threetier_service.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  description       = "Allow any outbound traffic."
}


# Security Group for Database Server
resource "aws_security_group" "database" {
  name_prefix = "threetier-database"
  description = "Database security group."
  vpc_id      = aws_vpc.main.id
}

resource "aws_security_group_rule" "database_allow_mysql_3306" {
  security_group_id        = aws_security_group.database.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = aws_security_group.threetier_service.id
  description              = "Allow incoming traffic from the Fruits service onto the database port."
}

resource "aws_security_group_rule" "database_allow_outbound" {
  security_group_id = aws_security_group.database.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  description       = "Allow any outbound traffic."
}