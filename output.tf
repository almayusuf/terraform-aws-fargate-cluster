output "alb_dns" {
  value       = aws_lb.threetier.dns_name
  description = "DNS name of the AWS ALB"
}



output "db_username" {
  description = "DB instance root username"
  value       = aws_db_instance.threetier.username
  sensitive   = true
}