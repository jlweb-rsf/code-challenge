terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}


provider "aws" {
  region = var.aws_region
}


terraform {
  backend "s3" {
    region         = "eu-west-2"
    bucket         = "assignment-terraform"
    key            = "terraform.tfstate"
    dynamodb_table = "terraform"
    profile        = ""
    role_arn       = ""
    encrypt        = true
  }
}
