variable "ingress_rules_web" {
    type = list(number)
    default = [80,433]
}

variable "egress_rules_web" {
    type = list(number)
    default = [80,433]
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

output "db_sg" {
    value = aws_security_group.db.name
}

output "db_web" {
    value = aws_security_group.web.name
}