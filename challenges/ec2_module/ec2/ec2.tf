module sg_module {
    source = "../sg"
}

resource "aws_instance" "instance_db" {
    ami = "ami-0a13d44dccf1f5cf6"
    instance_type = "t2.micro"
    security_groups = [module.sg_module.db_sg]
}

resource "aws_instance" "instance_web" {
    ami = "ami-0a13d44dccf1f5cf6"
    instance_type = "t2.micro"
    security_groups = [module.sg_module.db_web]
    user_data = file("./ec2/install-apache.sh")
}

output "db_ip" {
    value = aws_instance.instance_db.private_ip
}

output "web_ip" {
    value = aws_instance.instance_web.private_ip
}