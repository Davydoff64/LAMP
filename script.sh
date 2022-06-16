#!/bin/bash
user="user"
password="amazon"
database="arkady"
apt-get update -y
apt-get upgrade -y
apt-get install apache2 -y
apt-get install mariadb-server-10.3 -y
mysql -e "create database $database"
mysql -e "grant all privileges on $database.* to '$user'@localhost identified by '$password'"
mysql -e "flush privileges"
debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password root"
debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password root"
apt-get install phpmyadmin -y
sudo apt-get install git -y
git clone https://github.com/saikatbsk/TODO.git
sudo cp ./TODO/* /var/www/html/
sudo cp -a ./TODO/* /var/www/html/
rm /var/www/html/index.html
sudo sed -i 's\saikat\'$user'\g' /var/www/html/dbconnect.php
sudo sed -i 's\ppioneer\'$password'\g' /var/www/html/dbconnect.php
sudo sed -i 's\todo_db\'$database'\g' /var/www/html/dbconnect.php
curl 'http://127.0.0.1:80/install.php'
