provider "aws" {
  region = "eu-west-2"
}

# terraform plan -var-file=(dev|stage|prod).vars
variable "instances" {
  type = number
}

resource "aws_instance" "demo_instance" {
  ami           = "ami-0a13d44dccf1f5cf6"
  instance_type = "t2.micro"
  count         = var.instances
}
