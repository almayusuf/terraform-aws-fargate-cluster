resource "aws_db_subnet_group" "threetier" {
  name       = "main"
  subnet_ids = [aws_subnet.private.0.id, aws_subnet.private.1.id ]
}

resource "aws_db_instance" "threetier" {
  allocated_storage     = 50
  max_allocated_storage = 100
  engine                = "mysql"
  engine_version        = "8.0.27"
  instance_class        = "db.t3.micro"
  name                  = "wordpress"
  username              = "admin"
  password              = var.db_password
  db_subnet_group_name  = aws_db_subnet_group.threetier.name
  skip_final_snapshot   = true
  vpc_security_group_ids = [aws_security_group.database.id]
}