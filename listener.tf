# resource "aws_lb_listener" "listener" {
#   count             = var.INTERNAL? 1 : 0
#   load_balancer_arn = var.INTERNAL? data.terraform_remote_state.alb.outputs.PRIVATE_ALB_ARN : data.terraform_remote_state.alb.outputs.PUBLIC_ALB_ARN
#   port              = var.APP_PORT
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.app.arn
#   }
#   tags = {
#     Name = "Roboshop-${var.ENV}-listner"
#   }
# }