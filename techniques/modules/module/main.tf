provider "aws" {
  region = "eu-west-2"
}

module ec2_module {
  source   = "./ec2"
  ec2_name = "ec2_module"
}

output "module_output" {
  value = module.ec2_module.instance_id
}









