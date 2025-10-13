resource "aws_lb_target_group" "TG" {
  name        = "TG"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    "Name" = "prod-target-group"
  }
}

