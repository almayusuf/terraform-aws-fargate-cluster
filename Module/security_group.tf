module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "three-tier"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules            = ["http-80-tcp"]
}