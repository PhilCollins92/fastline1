FROM php:8.2-apache

# Installer les dépendances nécessaires
RUN apt-get update && \
    apt-get install -y \
    curl unzip sqlite3 git && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copier la configuration d'Apache et le script d'installation
COPY scripts/symfony.conf /etc/apache2/sites-available/
COPY scripts/script-1.sh /script-1.sh

# Rendre le script exécutable
RUN chmod +x /script-1.sh

# Cloner le dépôt depuis GitHub
RUN git clone https://github.com/PhilCollins92/fastline1.git /var/www/fastline1 && \
    chown -R www-data:www-data /var/www/fastline1 && \
    chmod -R 755 /var/www/fastline1

# Activer la configuration Symfony pour Apache
RUN a2dissite 000-default.conf && \
    a2ensite symfony.conf && \
    a2enmod rewrite

# Exécuter le script d'installation
RUN /script-1.sh

# Exposer le port 80
EXPOSE 80

# Lancer Apache
CMD ["apache2-foreground"]