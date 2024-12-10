#!/bin/bash
# Mise à jour des paquets nécessaires
echo "Mise à jour des paquets nécessaires..."
apt-get update && apt-get install -y \
    git \
    unzip \
    curl \
    php-cli \
    && apt-get clean

git clone https://github.com/PhilCollins92/fastline1.git
mv ~/fastlist /var/www/
cd /var/www/

ls /var/www/fastlist

# Désactiver le site par défaut et activer celui de Symfony
echo "Configuration d'Apache..."
a2dissite 000-default.conf
a2ensite symfony.conf
a2enmod rewrite

# Installer Composer
echo "Installation de Composer..."
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
composer --version

# Installer les dépendances avec Composer
echo "Installation des dépendances Symfony..."
cd "$APP_DIR" || exit 1
composer install --no-dev --optimize-autoloader

# Modifier le fichier .env pour l'environnement de production
echo "Configuration de l'environnement Symfony..."
sed -i 's/APP_ENV=dev/APP_ENV=prod/' /var/www/fastlist/.env

# Vider le cache Symfony pour l'environnement de production
composer install

echo "Vider le cache Symfony..."
php bin/console cache:clear --no-warmup --env=prod

# Configurer les permissions
echo "Configuration des permissions..."
chmod -R 777 "$APP_DIR/var"

echo "Le projet Symfony a été déployé avec succès dans $APP_DIR."