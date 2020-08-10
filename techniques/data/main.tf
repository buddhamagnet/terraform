provider "aws" {
  region = "eu-west-2"
}

data "aws_instances" "search" {
  filter {
    name   = "tag:name"
    values = [""]
  }
}

output "results" {
  value = data.aws_instances.search.public_ips
}