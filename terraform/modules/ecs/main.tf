resource "aws_ecs_cluster" "ecs_cluster_react_app" {
  name = var.cluster_name


  tags = {
    name = "${var.name_prefix}-react_app_cluster"
  }
}

resource "aws_ecs_service" "ecs_react_app_service" {
  name                               = var.ecs_service_name
  cluster                            = aws_ecs_cluster.ecs_cluster_react_app.id
  launch_type                        = var.ecs_launch_type_fargate
  platform_version                   = var.latest_platform_version
  scheduling_strategy                = var.scheduling_strategy_replica
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_percent
  task_definition                    = aws_ecs_task_definition.TD.arn
  desired_count                      = 2
  depends_on                         = [aws_lb_listener.listener, aws_iam_role.ecs_task_execution_role]



  load_balancer {
    target_group_arn = aws_lb_target_group.TG.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  network_configuration {
    assign_public_ip = false
    security_groups  = [aws_security_group.SG.id]
    subnets          = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]
  }
}

resource "aws_ecs_task_definition" "TD" {
  family                   = var.aws_ecs_task_definition_family
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  container_definitions = jsonencode([
    {
      name  = var.container_definition_name
      image = "${var.docker_user}/${var.docker_repo}:${var.imagetag}"

      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
        }
      ]
  }])

}

data "aws_ecs_task_definition" "TD" {
  task_definition = aws_ecs_task_definition.TD.family
}

