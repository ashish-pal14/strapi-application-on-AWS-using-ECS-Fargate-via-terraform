variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "ecr_image_url" {
  description = "ECR Docker image URL for Strapi"
}

variable "cpu" {
  description = "CPU units for ECS Task"
  default     = 512
}

variable "memory" {
  description = "Memory for ECS Task (MB)"
  default     = 1024
}

variable "desired_count" {
  description = "Number of ECS tasks"
  default     = 1
}

