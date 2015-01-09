# Variables
variable "access_key" {}
  variable "secret_key" {}
    variable "www_count" {
      default = "1"
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
