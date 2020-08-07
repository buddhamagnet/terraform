provider "aws" {
    region = "eu-west-2"
}

variable "vpc_name" {
    type = string
    default = "terraform_vpc"
}

variable "engineer_tags" {
    type = list(string)
    default = ["Buddhamagnet", "Matrix"]
}

variable "business_tags" {
    type = map
    default = {
        Department: "Digital"
    }
}

variable "code" {
    type = tuple([string, number])
    default = ["Code", 100]
}

variable "server" {
    type = object({name = string, port = number})
    default = {
        name = "Server12",
        port = 5432
    }
}

variable "inputname" {
    type = string
    description = "set the name of the vpc"
}

resource "aws_vpc" "terraform_vpc" {
    cidr_block = "192.168.0.0/24"
    tags = {
        Name = var.inputname
        Engineer = var.engineer_tags[0]
        Company = var.engineer_tags[1]
        Department = var.business_tags["Department"]
        ServerName = var.server.name
        ServerPort = var.server.port
        DomainName = var.code[0]
        DomainCode = var.code[1]
    }
}

output "vpcid" {
    value = aws_vpc.terraform_vpc.id
}