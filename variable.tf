variable "region" {
  default = "us-east-1"
}

variable "public_subnet_count" {
  type        = number
  description = "Number of public subnets to create"
  default     = 2
}


variable "private_subnet_count" {
  type        = number
  description = "Number of private subnets to create"
  default     = 2
}


variable "db_password" {
  description = "RDS root user password"
  type        = string
  default     = "wordpress"
}