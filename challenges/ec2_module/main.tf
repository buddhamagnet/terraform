provider "aws" {
    region = "eu-west-2"
}

module "ec2_module" {
    source = "./ec2"
}

output "instance_web_private_ip" {
    value = module.ec2_module.web_ip
}

output "instance_db_private_ip" {
    value = module.ec2_module.db_ip
}
