variable "aws_region" {
  default = "ap-southeast-2"
}

variable "vpc_cidr" {
  default = "10.2.0.0/23"
}

variable "private_subnet_db" {
  default = "10.2.0.0/27"
}

variable "public_subnet_webserver" {
  default = "10.2.0.32/27"
}