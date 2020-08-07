provider "aws" {
    region = "eu-west-2"
}

variable "ingress_rules_web" {
    type = list(number)
    default = [80,433]
}

variable "egress_rules_web" {
    type = list(number)
    default = [80,433]
}

resource "aws_eip" "demo_eip" {
    instance = aws_instance.instance_web.id
}

resource "aws_security_group" "db" {
    name = "allow DB"
    ingress {
      from_port = 3306
      to_port = 3306
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
      from_port = 3306
      to_port = 3306
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "web" {
    name = "allow web"
    dynamic "ingress" {
      iterator = port
      for_each = var.egress_rules_web
       content {
        from_port = port.value
        to_port = port.value
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
    dynamic "egress" {
      iterator = port
      for_each = var.egress_rules_web
       content {
        from_port = port.value
        to_port = port.value
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
}

resource "aws_instance" "instance_db" {
    ami = "ami-0a13d44dccf1f5cf6"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.db.name]
}

resource "aws_instance" "instance_web" {
    ami = "ami-0a13d44dccf1f5cf6"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.web.name]
    user_data = file("install-apache.sh")
}

output "instance_web_public_ip" {
    value = aws_instance.instance_web.public_ip
}

output "instance_db_private_ip" {
    value = aws_instance.instance_db.private_ip
}
