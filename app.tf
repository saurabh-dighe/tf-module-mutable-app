resource "null_resource" "remote_provisioner" {
  # Establishes connection to be used by all
  count = local.INSTANCE_COUNT
  connection {
    type     = "ssh"
    user     = local.SSH_USERNAME
    password = local.SSH_PASSWORD
    host     = element(local.INSTANCE_IDS, count.index)
  }

  provisioner "remote-exec" {
    inline = [
      "ansible-pull -U https://github.com/saurabh-dighe/Ansible.git -e ENV=dev -e COMPONENT=${var.COMPONENT} roboshop-pull.yml"
    ]
  }
}


