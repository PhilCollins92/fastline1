# Utiliser l'image Ubuntu comme base
FROM ubuntu:latest

# Mettre à jour et installer les dépendances
RUN apt-get update && apt-get install -y \
    php \
    php-cli \
    php-phar \
    php-mbstring \
    php-json \
    php-pdo \
    php-sqlite3 \
    php-tokenizer \
    php-xml \
    php-ctype \
    php-curl \
    apache2 \
    libapache2-mod-php \
    curl \
    git \
    sqlite3 \
    unzip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Télécharger et installer Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Télécharger et installer Symfony CLI
RUN curl -sS https://get.symfony.com/cli/installer -o symfony-installer.sh && \
    chmod +x symfony-installer.sh && \
    ./symfony-installer.sh && \
    mv /root/.symfony*/bin/symfony /usr/local/bin/symfony && \
    rm symfony-installer.sh

# Configurer Apache pour Symfony
RUN sed -i 's#/var/www/html#/app/public#' /etc/apache2/sites-available/000-default.conf && \
    a2enmod rewrite && \
    echo "<Directory \"/app/public\">\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>" >> /etc/apache2/apache2.conf

# Définir le répertoire de travail
WORKDIR /app

# Exposer le port 80
EXPOSE 80

# Commande par défaut pour démarrer Apache
CMD ["apache2ctl", "-D", "FOREGROUND"]