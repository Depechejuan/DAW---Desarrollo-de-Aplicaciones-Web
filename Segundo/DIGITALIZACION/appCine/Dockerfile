#Imagen base
FROM debian

LABEL org.opencontainers.image.authors="m.miraflor@edu.gva.es"

#Actualizaciones + instalación de VIM + instalación del servidor web apache + PHP
RUN apt update && \
    apt install -y apache2 && \
    apt install -y php libapache2-mod-php php-yaml php-mysql

#Habilitar las redirecciones y cabeceras
RUN a2enmod rewrite
RUN a2enmod headers

#Expongo el puerto de NGINX
EXPOSE 80

#Habilito apache para arranque cada vez que el contenedor se inicie
ENTRYPOINT ["apachectl", "-D", "FOREGROUND"]