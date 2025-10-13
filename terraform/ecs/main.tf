resource "aws_ecs_cluster" "ecs_cluster_react_app" {
  name = "react_app_cluster"


  tags = {
    "name" = "prod-react_app_cluster"
  }
}

resource "aws_ecs_service" "ecs_react_app_service" {
  name                               = "ecs_react_service"
  cluster                            = aws_ecs_cluster.ecs_cluster_react_app.id
  launch_type                        = "FARGATE"
  platform_version                   = "LATEST"
  scheduling_strategy                = "REPLICA"
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  task_definition                    = aws_ecs_task_definition.TD.arn
  desired_count                      = 2
  depends_on                         = [aws_lb_listener.listener, aws_iam_role.ecs_task_execution_role]



  load_balancer {
    target_group_arn = aws_lb_target_group.TG.arn
    container_name   = "react_app_container"
    container_port   = 80
  }

  network_configuration {
    assign_public_ip = false
    security_groups  = [aws_security_group.SG.id]
    subnets          = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]
  }
}

resource "aws_ecs_task_definition" "TD" {
  family                   = "NGINX"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  container_definitions = jsonencode([
    {
      name  = "react_app_container"
      image = "amdocker32695/ecs_proj_reacr_app:latest"

      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
  }])

}

data "aws_ecs_task_definition" "TD" {
  task_definition = aws_ecs_task_definition.TD.family
}

