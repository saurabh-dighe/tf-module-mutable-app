# Provisions a spot instance
resource "aws_spot_instance_request" "spot-app" {
  count                   = var.SPOT_INSTANCE_COUNT
  ami                     = data.aws_ami.ansible_ami.id
  instance_type           = var.SPOT_INSTANCE_TYPE
  subnet_id               = var.INTERNAL? element(data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_ID, count.index) : element(data.terraform_remote_state.vpc.outputs.PUBLIC_SUBNET_ID, count.index)
  vpc_security_group_ids  = var.INTERNAL? element(aws_security_group.allow_private.*.id, count.index) : element(aws_security_group.allow_public.*.id, count.index)
  wait_for_fulfillment    = true
  iam_instance_profile    = "EC2-admin"

  tags = {
    Name = "roboshop-${var.ENV}-${var.COMPONENT}-spot-request"
  }
}
resource "aws_ec2_tag" "spot-app" {
  count       = var.SPOT_INSTANCE_COUNT
  resource_id = aws_spot_instance_request.spot-app[count.index].spot_instance_id
  key         = "Name"
  value       = "roboshop-${var.ENV}-${var.COMPONENT}-SPOT"
}

resource "aws_instance" "OD-app"{
  count = var.OD_INSTANCE_COUNT
  ami                     = data.aws_ami.ansible_ami.id
  instance_type           = var.OD_INSTANCE_TYPE
  subnet_id               = var.INTERNAL? element(data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_ID, count.index) : element(data.terraform_remote_state.vpc.outputs.PUBLIC_SUBNET_ID, count.index)
  vpc_security_group_ids  = var.INTERNAL? element(aws_security_group.allow_private.*.id, count.index) : element(aws_security_group.allow_public.*.id, count.index)
  iam_instance_profile    = "EC2-admin"

  tags = {
    Name = "roboshop-${var.ENV}-${var.COMPONENT}-OD"
  }
}
# Provisions a OD instance

# resource "null_resource" "remote_provisioner" {
#   # Establishes connection to be used by all
#   connection {
#     type     = "ssh"
#     user     = local.SSH_USERNAME
#     password = local.SSH_PASSWORD
#     host     = aws_spot_instance_request.rabbitmq.private_ip
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "ansible-pull -U https://github.com/saurabh-dighe/Ansible.git -e ENV=dev -e COMPONENT=rabbitmq roboshop-pull.yml"
#     ]
#   }
# }


