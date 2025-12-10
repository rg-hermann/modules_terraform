resource "aws_lb" "this" {
  name            = var.name
  internal        = var.internal
  load_balancer_type = var.type
  security_groups = var.security_groups
  subnets         = var.subnets
  tags            = var.tags
}

resource "aws_lb_target_group" "this" {
  name        = var.target_group_name
  port        = var.target_port
  protocol    = var.protocol
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_port
  protocol          = var.protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
