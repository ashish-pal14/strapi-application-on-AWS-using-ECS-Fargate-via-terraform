variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "image_tag" {
  type        = string
  description = "Docker image tag (e.g., full sha) to deploy"
  default     = "latest"
}

variable "docker_repo" {
  type        = string
  description = "Docker repo (e.g. username/strapi-app)"
  default     = "ashishpal14/strapi"
}

variable "ssh_public_key" {
  type        = string
  description = "Public SSH key used to create AWS key pair"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

