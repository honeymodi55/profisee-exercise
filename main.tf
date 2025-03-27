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
  #access_key = var.aws_access_key
  #secret_key = var.aws_secret_key

  #assume_role {
  #  role_arn = "arn:aws:iam::273354629542:role/level-1-handsOn-ques"
  #}
}

module "level1" {
  source = "./level1"
}