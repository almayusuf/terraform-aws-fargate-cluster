data "aws_availability_zones" "available" {
  state = "available"
}

// resource "random_string" "fqdn" {
//   length  = 4
//   special = false
//   upper   = false
//   number  = false
// }
