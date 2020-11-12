resource "upcloud_server" "poste" {
  hostname = "poste"
  count = 1
  zone = "us-nyc1"
  plan = "1xCPU-1GB"

  storage_devices {
    size = 25
    storage = "Ubuntu Server 20.04 LTS (Focal Fossa)"
    tier   = "maxiops"
    action = "clone"
  }

  network_interface {
    type = "public"
  }

  network_interface {
    type = "utility"
  }

  login {
    user = "quentin"
    keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCu6iQ1jqQqgeMT2g41kBK1sHlbzdN6RcUrzT1+n+QSd7CV+PkjNyvMzN6w9TlM3AiGznxVk1yD36SjYSnabN6KWy9c+q63zu+lHykeprovL4pDooYLFfPXRXIe3KinpY4WLQH0qDi+xNrDUwn1hy8MzLne8hScOOWsJXY9+3OCMsF1Tj9B/ggvvmhyLQkEx67cLsbGxZLIfpodzNdyLF5U2FG8RE2N2L81o31Uasyn1nCBSfDVUNxInrnCRgNpztloGZ2j8LQFeBIjd4gsKOrZICqTTBivQlxmi7P7Wj4Nuvr3AfK1gZX1utqH5I93m/WLotveBS/3VPWlgznLHa1/ quentin@PC-fuckoff",
    ]
    create_password = false
  }

  connection {
    host        = self.network_interface[0].ip_address
    type        = "ssh"
    user        = "quentin"
    private_key = file("id_rsa")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y docker.io docker-compose",
      "sudo usermod -aG docker $USER"
    ]
  }
}
