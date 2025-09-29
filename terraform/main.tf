provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "your-tf-state-bucket"
    key    = "strapi/terraform.tfstate"
    region = "us-east-1"
  }
}

