#!/bin/bash
sudo amazon-linux-extras enable epel
sudo yum install epel-release -y
sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
sudo yum-config-manager --enable remi-php54
sudo yum install php php-cli php-common php-mbstring php-xml php-mysql php-fpm -y
sudo yum install httpd git -y
sudo systemctl enable httpd
sudo systemctl start httpd
git clone https://github.com/ORT-FI-7417-SolucionesCloud/php-ecommerce-obligatorio.git
cp -r php-ecommerce-obligatorio/* /var/www/html/