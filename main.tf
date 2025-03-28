terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.92.0"
    }
  }

  backend "s3" {
    bucket = "profisee-tfstate"
    key = "state-file"
    region = "us-west-2"
  }
}

provider "aws" {
  region = "us-west-2"
}

module "level1" {
  source = "./level1"
}

module "level2" {
  source = "./level2"
  vpc_id = module.level1.vpc_id
  private_subnet_id = module.level1.private_subnet_id
  public_subnet_id = module.level1.public_subnet_id
  security_group_id = module.level1.security_group_id
}