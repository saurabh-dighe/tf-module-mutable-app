resource "null_resource" "remote_provisioner" {
  # Establishes connection to be used by all
  connection {
    type     = "ssh"
    user     = local.SSH_USERNAME
    password = local.SSH_PASSWORD
    host     = aws_spot_instance_request.rabbitmq.private_ip
  }

  provisioner "remote-exec" {
    inline = [
      "ansible-pull -U https://github.com/saurabh-dighe/Ansible.git -e ENV=dev -e COMPONENT=${var.COMPONENT} roboshop-pull.yml"
    ]
  }
}


