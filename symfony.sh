#!/bin/bash

# Variables
REPO_URL="https://github.com/PhilCollins92/fastline1.git"
APP_DIR="/var/www/fastline1"
BRANCH="main"

echo "=== Mise à jour des paquets et installation de LAMP ==="
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y apache2 php libapache2-mod-php php-sqlite3 php-xml php-zip php-mbstring php-intl php-curl

echo "=== Installation de Composer ==="
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer