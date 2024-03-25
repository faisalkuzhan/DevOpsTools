# Resmi PHP-Apache görüntüsünü kullan
FROM php:7.4-apache
# Gerekli PHP eklentilerini etkinleştir
RUN docker-php-ext-install mysqli
WORKDIR /var/www/html
COPY . /var/www/html/
RUN chmod 777 images
# Ortam değişkenleri tanımla
#ENV DB_HOST=mysql-host
#ENV MYSQL_USER=mysql-user
#ENV MYSQL_PASSWORD=mysql-password
#ENV MYSQL_DATABASE=mysql-database
# Apache URL yeniden yazma etkinleştir
RUN a2enmod rewrite
# Giriş sayfasını etkinleştir
RUN a2ensite 000-default.conf
# Apache'yi yeniden başlat
RUN service apache2 restart
# Docker konteyner çalıştığında bu komutu çalıştır
CMD ["apache2-foreground"]
