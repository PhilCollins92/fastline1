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
    mysql-server \
    curl \
    git \
    sqlite3 \
    unzip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*


# Définir le répertoire de travail
WORKDIR /var/www/html

# Exposer le port 80 pour Apache
EXPOSE 80

# Commande par défaut pour démarrer Apache
CMD ["apache2ctl", "-D", "FOREGROUND"]
