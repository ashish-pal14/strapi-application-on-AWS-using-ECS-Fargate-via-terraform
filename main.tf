provider "aws" {
  region = "us-east-1" # Change to your preferred region
}



# Security Group for SSH + Strapi port
resource "aws_security_group" "strapi_sg" {
  name        = "strapi-sg"
  description = "Allow SSH and Strapi port"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
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

# EC2 Instance
resource "aws_instance" "strapi_ec2" {
  ami           = "ami-0c02fb55956c7d316"  # Amazon Linux 2
  instance_type = "t2.large"
  key_name      = "ec2"  
  security_groups = [aws_security_group.strapi_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              service docker start
              usermod -a -G docker ec2-user

              # Pull the Docker image

              sudo docker pull ashishpal14/strapi-app:latest

              # Run Strapi container with environment variables
              sudo docker run -d -p 1337:1337 --name strapi ashishpal14/strapi-app:latest 
                
              EOF

  tags = {
    Name = "StrapiServer"
  }
}

