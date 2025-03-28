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
