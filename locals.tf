locals {
  INSTANCE_COUNT = var.OD_INSTANCE_COUNT + var.SPOT_INSTANCE_COUNT
  INSTANCE_IDS   = concat(aws_spot_instance_request.spot-app.*.spot_instance_id, aws_instance.OD-app.*.id)
}
