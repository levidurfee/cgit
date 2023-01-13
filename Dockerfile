FROM debian:11.6-slim
RUN apt-get update &&  \
    apt-get install -y \
    apache2            \
    apache2-utils      \
    python3-pygments   \
    build-essential    \
    libssl-dev         \
    zlib1g-dev         \
    git

WORKDIR /app
RUN git clone https://git.zx2c4.com/cgit

WORKDIR /app/cgit
RUN git submodule init
RUN git submodule update
RUN make
RUN make install

COPY cgit.conf /etc/apache2/conf-available/cgit.conf
COPY cgitrc /etc/cgitrc
COPY favicon.ico /var/www/htdocs/cgit/favicon.ico

RUN a2enconf cgit
RUN a2enmod cgid rewrite

EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
