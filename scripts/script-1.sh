#!/bin/bash
# Variables
REPO_URL="https://github.com/PhilCollins92/fastline1.git"
APP_DIR="/var/www/fastline1/"
BRANCH="main"

# Mise à jour des paquets nécessaires
echo "Mise à jour des paquets nécessaires..."
apt-get update && apt-get install -y \
    git \
    unzip \
    curl \
    php-cli \
    && apt-get clean

# Désactiver le site par défaut et activer celui de Symfony
echo "Configuration d'Apache..."
a2dissite 000-default.conf
a2ensite symfony.conf
a2enmod rewrite

# Cloner le dépôt depuis GitHub
if [ ! -d "$APP_DIR" ]; then
    echo "Clonage du dépôt Git..."
    git clone --branch "$BRANCH" "$REPO_URL" "$APP_DIR"
    chown -R www-data:www-data "$APP_DIR"
    chmod -R 755 "$APP_DIR"
else
    echo "Le dépôt existe déjà, mise à jour des fichiers..."
    cd "$APP_DIR" || exit 1
    git pull origin "$BRANCH"
fi

# Installer Composer
echo "Installation de Composer..."
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
composer --version

# Installer les dépendances avec Composer
echo "Installation des dépendances Symfony..."
cd "$APP_DIR" || exit 1
composer install --no-dev --optimize-autoloader

# Configurer l'environnement de production
echo "Configuration de l'environnement Symfony..."
if [ -f .env ]; then
    sed -i 's/APP_ENV=dev/APP_ENV=prod/' .env
fi

# Vider le cache Symfony pour l'environnement de production
composer install

echo "Vider le cache Symfony..."
php bin/console cache:clear --no-warmup --env=prod

# Configurer les permissions
echo "Configuration des permissions..."
chmod -R 777 "$APP_DIR/var"

echo "Le projet Symfony a été déployé avec succès dans $APP_DIR."