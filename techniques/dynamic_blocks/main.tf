provider "aws" {
  region = "eu-west-2"
}

variable "ingress_rules" {
  type    = list(number)
  default = [80, 433]
}

variable "egress_rules" {
  type    = list(number)
  default = [80, 433, 25, 3306, 53, 8080]
}

resource "aws_security_group" "web_https" {
  name = "allow HTTPS"
  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_rules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  dynamic "egress" {
    iterator = port
    for_each = var.egress_rules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

resource "aws_instance" "instance_dynamic_blocks" {
  ami             = "ami-0a13d44dccf1f5cf6"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.web_https.name]
}

output "instance" {
  value = aws_instance.instance_dynamic_blocks.id
}

output "vpc" {
  value = aws_security_group.web_https.vpc_id
}

