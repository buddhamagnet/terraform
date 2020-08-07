provider "aws" {
    region = "eu-west-2"
}

resource "aws_eip" "demo_eip" {
    instance = aws_instance.demo_instance.id
}

resource "aws_security_group" "web_sg" {
    name = "allow HTTPS"
    ingress {
      from_port = 443
      to_port = 443
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
      from_port = 443
      to_port = 443
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "demo_instance" {
    ami = "ami-0a13d44dccf1f5cf6"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.web_sg.name]
}

output "eip" {
    value = aws_eip.demo_eip.public_ip
}



output "instance" {
    value = aws_instance.demo_instance.id
}

