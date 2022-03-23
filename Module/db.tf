resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "My DB subnet group"
  }
}



resource "aws_db_instance" "threetier" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0.27"
  instance_class       = "db.t3.micro"
  // db_name              = "wordpress"
  name                 = "wordpress"
  username             = "admin"
  password             = "wordpress"
//   parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.default.name
}