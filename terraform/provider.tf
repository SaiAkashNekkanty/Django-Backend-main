terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.77.0"  # or your desired version
    }
    template = {
      source = "hashicorp/template"
      version = "2.1.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  default_tags {
    tags = {
      Environment = terraform.workspace
    }
  }
}
