provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket = "your-tf-state-bucket"
    key    = "strapi/terraform.tfstate"
    region = "ap-south-1"
  }
}

