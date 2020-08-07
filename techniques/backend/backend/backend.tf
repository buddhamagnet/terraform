terraform {
    backend "s3" {
        bucket = "terraform-buddhamagnet"
        key = "terraform/tfstate.tfstate"
        region = "eu-west-2"
        access_key = ""
        secret_key = ""
    }
}