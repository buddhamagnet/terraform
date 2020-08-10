variable "ec2_name" {
  type = string
}

resource "aws_security_group" "web_sg" {
  name = "allow HTTP"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.ec2_name
  }
}

resource "aws_instance" "demo_instance" {
  ami             = "ami-0a13d44dccf1f5cf6"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.web_sg.name]
}

output "instance_id" {
  value = aws_instance.demo_instance.id
}