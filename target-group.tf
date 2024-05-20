resource "aws_lb_target_group" "app" {
  name     = "${var.COMPONENT}-${var.ENV}-target-group"
  port     = var.APP_PORT
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.VPC_ID

  health_check {
    enabled             = true             # Enable health checks (default)
    interval            = 10               # Check every 30 seconds
    path                = "/health"        # Path to check (e.g., root for web servers)   
    healthy_threshold   = 3                # 3 successful checks mark target healthy
    unhealthy_threshold = 2                # 2 failed checks mark target unhealthy
    timeout             = 5                # 5 seconds timeout for each check           # Successful response codes (HTTP status 200)
  }
}

resource "aws_lb_target_group_attachment" "app" {
  count            = local.INSTANCE_COUNT
  
  target_group_arn = aws_lb_target_group.app.arn
  target_id        = element(local.INSTANCE_IDS, count.index)
  port             = var.APP_PORT
}
