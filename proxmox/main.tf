variable "cloudinit_template_name" {
    type = string 
}

variable "proxmox_node" {
    type = string
}

variable "ssh_key" {
  type = string 
  sensitive = true
}

resource "proxmox_vm_qemu" "debian" {
  name = "debian-01"
  onboot = true
  target_node = var.proxmox_node
  clone = var.cloudinit_template_name
  agent = 1
  os_type = "cloud-init"
  cores = 4
  sockets = 1
  cpu = "host"
  memory = 1024
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"

  disk {
    slot = 0
    size = "10G"
    type = "scsi"
    storage = "local-lvm"
  }

  network {
    model = "virtio"
    bridge = "vmbr0"
  }
  
  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0 = "ip=dhcp"
  nameserver = "10.10.4.1"

  ciuser = "debian"
  cipassword = "testing123"
  
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF

}