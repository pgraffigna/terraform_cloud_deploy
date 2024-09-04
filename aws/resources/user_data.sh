#!/bin/bash
yum update -y
yum install -y httpd
systemctl enable httpd --now
echo "<h1>Hola AWS! desde $(hostname -f)</h1>" > /var/www/html/index.html