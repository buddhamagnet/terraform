provider "aws" {
    region = "eu-west-2"
}

resource "aws_db_instance" "demo_db" {
  name = "demo_db"
  identifier = "mydemodb"
  instance_class = "db.t2.micro"
  engine = "mariadb"
  engine_version = "10.2.21"
  username = "admin1967"
  password = "admin1967"
  port = 3306
  allocated_storage = 20
  skip_final_snapshot = true
}


