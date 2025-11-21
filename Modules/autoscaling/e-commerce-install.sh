#!/bin/bash
DB_ENDPOINT=$1
DB_USER=$2
DB_PASSWORD=$3
DB_DATABASE=$4

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
sudo yum install php-mysql.x86_64
mysql -h {db_endpoint} -u db_user -p e-commerce < /var/www/html/dump.sql
sudo systemctl restart httpd
cat <<EOF > /var/www/html/config.php
<?php
    ini_set('display_errors',1);
    error_reporting(-1);
    define('DB_HOST', '$DB_ENDPOINT');
    define('DB_USER', '$DB_USER');
    define('DB_PASSWORD', '$DB_PASSWORD');
    define('DB_DATABASE', '$DB_DATABASE');
?>
EOF