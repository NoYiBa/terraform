
variable "access_key" {}
variable "secret_key" {}
variable "www_count" {
  default = "2"
}
variable "aws_region" {
  default = "eu-west-1"
}

variable "key_name" {}
variable "key_path" {}

variable "aws_amis" {
  default = {
    eu-west-1 = "ami-b1cf19c6"
    us-east-1 = "ami-de7ab6b6"
    us-west-1 = "ami-3f75767a"
    us-west-2 = "ami-21f78e11"
  }
}

variable "project" {
  default = "tf-demo"
}

# AWS provider
provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "${var.aws_region}"
}

# Security group
resource "aws_security_group" "default" {
    name = "tf-demo-sg"
    description = "Used in the terraform"

    # SSH access from anywhere
    ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    # HTTP access from anywhere
    ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

}

# DNS
resource "aws_route53_zone" "primary" {
   name = "tfdemo.com"
}
