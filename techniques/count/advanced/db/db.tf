variable "server_names" {
    type = list(object({name=string, engine=string}))
}

resource "aws_db_instance" "demo_db" {
  count = length(var.server_names)
  name = "demo_db"
  identifier = "mydemodb"
  instance_class = "db.t2.micro"
  engine = var.server_names[count.index].engine
  username = "admin1967"
  password = "admin1967"
  port = 3306
  allocated_storage = 20
  skip_final_snapshot = true
  tags = {
      Name = var.server_names[count.index].name
  }
}

output "db_identifier" {
    value = [aws_db_instance.demo_db.*.address]
}
