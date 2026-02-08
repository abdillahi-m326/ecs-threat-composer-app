output "vpc_id" {
  description = "VPC ID from the VPC module"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs from the VPC module"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs from the VPC module"
  value       = module.vpc.private_subnet_ids
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer that routes traffic to the ECS service"
  value       = module.alb.alb_dns_name
}

output "domain_name" {
  description = "Public domain name associated with the ECS application"
  value       = "threatcomposerecsabdillahi.click"
}

output "ecs_cluster_id" {
  description = "ID of the ECS cluster hosting the application services"
  value       = module.ecs.cluster_id
}

output "ecs_service_name" {
  description = "Name of the ECS service running the application tasks"
  value       = module.ecs.service_name
}