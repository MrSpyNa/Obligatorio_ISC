#!/bin/bash
endpoint="${db_endpoint}"
user="${db_user}"
password="${db_password}"
database="${db_database}"
token="${git_token}"
GIT_REPO_URL="https://$${token}@github.com/ORT-FI-7417-SolucionesCloud/php-ecommerce-obligatorio.git"
sudo amazon-linux-extras enable epel
sudo yum install epel-release -y
sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
sudo yum-config-manager --enable remi-php54
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022 #
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2023 #
sudo rpm -Uvh https://repo.mysql.com/mysql57-community-release-el7.rpm
sudo yum install -y mysql-community-client #
sudo yum install php php-cli php-common php-mbstring php-xml php-mysql php-fpm -y
sudo yum install php-mysql.x86_64 -y
sudo yum install httpd git -y
sudo systemctl enable httpd
sudo systemctl start httpd
git clone "$${GIT_REPO_URL}"
cp -r php-ecommerce-obligatorio/* /var/www/html/
mysql -h "$${endpoint}" -u "$${user}" -p"$${password}" "$${database}" < /var/www/html/dump.sql
sudo systemctl restart httpd
cat <<EOF > /var/www/html/config.php
<?php
    ini_set('display_errors',1);
    error_reporting(-1);
    define('DB_HOST', '$${endpoint}');
    define('DB_USER', '$${user}');
    define('DB_PASSWORD', '$${password}');
    define('DB_DATABASE', '$${database}');
?>
EOF