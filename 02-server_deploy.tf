resource "upcloud_server" "testing" {
  hostname = "testing.cultura.lab"
  count = 1
  zone = "us-nyc1"
  plan = "1xCPU-1GB"

  template {
    size = 25
    storage = "Ubuntu Server 20.04 LTS (Focal Fossa)"
  }

  network_interface {
    type = "public"
  }

  network_interface {
    type = "utility"
  }

  login {
    user = "root"
    keys = [
      "ssh-rsa pub_key"
    ]
    create_password = false
  }

  connection {
    host        = self.network_interface[0].ip_address
    type        = "ssh"
    user        = "root"
    private_key = file("~/.ssh/id_rsa")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y docker.io docker-compose",
      "sudo usermod -aG docker $USER"
    ]
  }
}
