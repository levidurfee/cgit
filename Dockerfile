FROM debian:11.6
RUN apt-get update &&  \
    apt-get install -y \
    python3-pygments   \
    apache2            \
    git                \
    cgit

RUN apt install apache2-utils -y
RUN apt clean
RUN git init --bare /var/git/example.git
RUN echo 'Hello world' > /var/git/example.git/description

COPY cgit.conf /etc/apache2/conf-available/cgit.conf
COPY cgitrc /etc/cgitrc

RUN a2enconf cgit
RUN a2enmod cgid

EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
