variable "cluster_name" {
  description = "Name for cluster"
  type        = string
  default     = "react_app_cluster"
}

variable "name_prefix" {
  description = "Prefix for naming IAM roles"
  type        = string
}

variable "ecs_service_name" {
  description = "Name of ecs service"
  type        = string
  default     = "ecs_react_service"
}

variable "ecs_launch_type_fargate" {
  description = "Fargate as the launch type for ecs"
  type        = string
  default     = "FARGATE"
}

variable "latest_platform_version" {
  description = "Latest platform version"
  type        = string
  default     = "LATEST"
}

variable "scheduling_strategy_replica" {
  description = "Replica"
  type        = string
  default     = "REPLICA"
}

variable "deployment_maximum_percent" {
  description = "Maximum deployment percentage"
  type        = number
  default     = 200
}

variable "deployment_minimum_percent" {
  description = "Minimum deployment percentage"
  type        = number
  default     = 100
}
variable "container_name" {
  description = "Name of container"
  type        = string
  default     = "react_app_container"
}

variable "container_port" {
  description = "Port number for container"
  type        = number
  default     = 80
}

variable "container_image" {
  description = "Image from docker/ECR used for container"
  type        = string
  default     = "amdocker32695/ecs_proj_reacr_app:latest"
}

variable "container_definition_name" {
  description = "Name of container definition"
  type        = string
  default     = "react_app_container"
}

variable "task_cpu" {
  description = "cpu capacity for task"
  type        = number
  default     = 1024
}

variable "task_memory" {
  description = "memory capacity for task"
  type        = number
  default     = 2048
}

variable "docker_user" {
  description = "Docker user name"
  type        = string
  default     = "amdocker32695"
}

variable "docker_repo" {
  description = "Docker repository name"
  type        = string
  default     = "ecs_proj_reacr_app"
}

variable "imagetag" {
  description = "Docker image tag to deploy"
  type        = string
  default     = "latest"
}

variable "aws_ecs_task_definition_family" {
  type    = string
  default = "threat_composer_service_task"
}
