terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.14"
    }
  }
  required_version = ">= 1.5.7"
}

provider "aws" {
  region = var.aws_region
}

# get latest Amazon Linux 2 AMI (works across regions)
data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_security_group" "strapi_sg" {
  name        = "strapi-sg"
  description = "Allow SSH and Strapi HTTP"
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Strapi port"
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "strapi-deploy-key"
  public_key = var.ssh_public_key
}

resource "aws_instance" "strapi" {
  ami                    = data.aws_ami.amazon_linux2.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.strapi_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    set -e
    yum update -y
    amazon-linux-extras install docker -y || yum install -y docker
    systemctl enable --now docker
    usermod -a -G docker ec2-user
    sleep 5
    docker pull ${var.docker_repo}:${var.image_tag}
    docker stop strapi || true
    docker rm strapi || true
    docker run -d --name strapi -p 1337:1337 ${var.docker_repo}:${var.image_tag}
  EOF

  tags = {
    Name = "strapi-server"
  }
}

output "public_ip" {
  description = "Public IP of the Strapi server"
  value       = aws_instance.strapi.public_ip
}

output "public_dns" {
  value = aws_instance.strapi.public_dns
}
