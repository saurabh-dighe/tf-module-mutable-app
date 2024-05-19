resource "aws_route53_record" "record" {
  zone_id = var.INTERNAL ? data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTEDZONE_ID : data.terraform_remote_state.vpc.outputs.PUBLIC_HOSTEDZONE_ID
  name    = "${COMPONENT}-${var.ENV}"
  type    = "A"
  ttl     = 10
  records = var.INTERNAL ? [data.terraform_remote_state.alb.outputs.PRIVATE_ALB_ADDRESS] : [data.terraform_remote_state.alb.outputs.PUBLIC_ALB_ADDRESS]
}
