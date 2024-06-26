locals {
  INSTANCE_COUNT = var.OD_INSTANCE_COUNT + var.SPOT_INSTANCE_COUNT
  INSTANCE_IDS   = concat(aws_spot_instance_request.spot-app.*.spot_instance_id, aws_instance.OD-app.*.id)
  INSTANCE_IPS   = concat(aws_spot_instance_request.spot-app.*.private_ip, aws_instance.OD-app.*.private_ip)
  
  SSH_USERNAME   = jsondecode(data.aws_secretsmanager_secret_version.secret_version.secret_string)["SSH_USERNAME"]
  SSH_PASSWORD   = jsondecode(data.aws_secretsmanager_secret_version.secret_version.secret_string)["SSH_PASSWORD"]
}