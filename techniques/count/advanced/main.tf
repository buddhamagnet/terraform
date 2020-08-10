provider "aws" {
  region = "eu-west-2"
}

module "db" {
  source       = "./db"
  server_names = [{ name = "server1", engine = "mariadb" }, { name = "server2", engine = "mysql" }, { name = "server3", engine = "mssql" }]
}

output "instance_id_1" {
  value = module.db.db_identifier
}
