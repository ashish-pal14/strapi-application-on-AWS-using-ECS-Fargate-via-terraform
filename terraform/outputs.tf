output "strapi_url" {
  description = "Public URL to access Strapi via ALB"
  value       = aws_lb.alb.dns_name
}

