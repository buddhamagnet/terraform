provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "demo_instance" {
  ami           = "ami-0a13d44dccf1f5cf6"
  instance_type = "t2.micro"
  count         = 3
}

output "instance_id_1" {
  value = aws_instance.demo_instance[0].id
}

output "instance_id_2" {
  value = aws_instance.demo_instance[1].id
}

output "instance_id_3" {
  value = aws_instance.demo_instance[2].id
}