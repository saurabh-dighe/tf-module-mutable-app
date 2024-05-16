locals {
  INSTANCE_COUNT = var.OD_INSTANCE_COUNT + var.SPOT_INSTANCE_COUNT
  INSTANCE_IDS   = concat(aws_spot_instance_request.spot-app.*.spot_instance_id, aws_instance.OD-app.*.id)
  SSH_USERNAME   = data.aws_secretsmanager_secret_version.secret_version.secret_string[4]
  SSH_PASSWORD   = data.aws_secretsmanager_secret_version.secret_version.secret_string[5]
}

output "name" {
    value = local.SSH_PASSWORD
}