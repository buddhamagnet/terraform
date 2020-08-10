provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "demo_instance1" {
  ami           = "ami-0a13d44dccf1f5cf6"
  instance_type = "t2.micro"
}

resource "aws_instance" "demo_instance2" {
  ami           = "ami-0a13d44dccf1f5cf6"
  instance_type = "t2.micro"
  depends_on    = [aws_instance.demo_instance1]
}


