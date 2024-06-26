# Provisions a spot instance
resource "aws_spot_instance_request" "spot-app" {
  count                       = var.SPOT_INSTANCE_COUNT

  ami                         = data.aws_ami.ansible_ami.id
  instance_type               = var.SPOT_INSTANCE_TYPE
  subnet_id                   = var.INTERNAL? element(data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_ID, count.index) : element(data.terraform_remote_state.vpc.outputs.PUBLIC_SUBNET_ID, count.index)
  vpc_security_group_ids      = var.INTERNAL? element([aws_security_group.allow_private.*.id], count.index) : element([aws_security_group.allow_public.*.id], count.index)
  # associate_public_ip_address = var.INTERNAL? false : true
  wait_for_fulfillment        = true
  iam_instance_profile        = "EC2-Admin"
}

resource "aws_instance" "OD-app"{
  count                       = var.OD_INSTANCE_COUNT

  ami                         = data.aws_ami.ansible_ami.id
  instance_type               = var.OD_INSTANCE_TYPE
  subnet_id                   = var.INTERNAL? element(data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_ID, count.index) : element(data.terraform_remote_state.vpc.outputs.PUBLIC_SUBNET_ID, count.index)
  vpc_security_group_ids      = var.INTERNAL? element([aws_security_group.allow_private.*.id], count.index) : element([aws_security_group.allow_public.*.id], count.index)
  # associate_public_ip_address = var.INTERNAL? false : true
  iam_instance_profile        = "EC2-Admin"
}
resource "aws_ec2_tag" "app-tag" {
  count                       = local.INSTANCE_COUNT
  
  resource_id                 = element(local.INSTANCE_IDS, count.index)
  key                         = "Name"
  value                       = "roboshop-${var.ENV}-${var.COMPONENT}-${count.index+1}"
}
resource "aws_ec2_tag" "monitor-tag" {
  count                       = local.INSTANCE_COUNT
  
  resource_id                 = element(local.INSTANCE_IDS, count.index)
  key                         = "monitor"
  value                       = "yes"
}