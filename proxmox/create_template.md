### Descargando imagen
```command
wget -q --show-progress --progress=bar:force 2>&1 https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-generic-amd64.qcow2 -O /var/lib/vz/template/iso/debian-11-generic-amd64.qcow2
```

### virt-tools
```command
apt install libguestfs-tools -y
```

### Editando cloud-image
```command
virt-customize -a debian-11-generic-amd64.qcow2 --install qemu-guest-agent
virt-customize -a debian-11-generic-amd64.qcow2 --run-command "echo -n > /etc/machine-id"
```

### Creando template
```command
qm create 5001 --name "debian-cloud-template" --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0
qm importdisk 5001 debian-11-generic-amd64.qcow2 local-lvm
qm set 5001 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-5001-disk-0
qm set 5001 --boot c --bootdisk scsi0
qm set 5001 --ide2 local-lvm:cloudinit
qm set 5001 --serial0 socket --vga serial0
qm set 5001 --agent enabled=1
qm template 5001
```

### Creando rol para terraform 
```command
pveum role add terraform_role -privs "Datastore.AllocateSpace Datastore.Audit Pool.Allocate Sys.Audit Sys.Console Sys.Modify VM.Allocate VM.Audit VM.Clone VM.Config.CDROM VM.Config.Cloudinit VM.Config.CPU VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Migrate VM.Monitor VM.PowerMgmt"
```

### Creando usuario para terraform
```command
pveum user add terra_user@pve --password P@ssw0rd123!
```

### Asignando rol a usuario
```command
pveum aclmod / -user terraform_user@pve -role terraform_role
```

### Exportando datos para conectar en cliente
```command
export PM_USER="terra_user@pve"
export PM_PASS="P@ssw0rd123!"   
```

### Creando vm
```command
terraform init
terraform plan
terraform apply
```



