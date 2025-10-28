output "ecs_service_arn" {
  description = "ARN of the ECS service"
  value       = aws_ecs_service.ecs_react_app_service.arn
}

output "ecs_cluster_arn" {
  description = "ARN of the ECS cluster"
  value       = aws_ecs_cluster.ecs_cluster_react_app.arn
}
