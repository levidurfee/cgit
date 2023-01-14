FROM debian:11.6-slim
RUN apt-get update &&  \
    apt-get install -y \
    nginx              \
    fcgiwrap           \
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

COPY nginx.conf /etc/nginx/nginx.conf
COPY cgitrc /etc/cgitrc
COPY favicon.ico /var/www/htdocs/cgit/favicon.ico
COPY 40-fcgiwrap.sh /docker-entrypoint.d/40-fcgiwrap.sh

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
