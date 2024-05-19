resource "null_resource" "remote_provisioner" {
  # Establishes connection to be used by all
  triggers = {always_run = timestamp() }

  count = local.INSTANCE_COUNT
  connection {
    type     = "ssh"
    user     = local.SSH_USERNAME
    password = local.SSH_PASSWORD
    host     = element(local.INSTANCE_IPS, count.index)
  }

  provisioner "remote-exec" {
    inline = [
      "ansible-pull -U https://github.com/saurabh-dighe/Ansible.git -e ENV=dev -e COMPONENT=${var.COMPONENT} -e DOCDB_ENDPOINT=${data.terraform_remote_state.db.outputs.DOCDB_ENDPOINT} -e REDIS_ENDPOINT=${data.terraform_remote_state.db.outputs.REDIS_ENDPOINT} -e MYSQL_ENDPOINT=${data.terraform_remote_state.db.outputs.MYSQL_ENDPOINT} -e APP_VERSION=${var.APP_VERSION} roboshop-pull.yml"
    ]
  }
}


