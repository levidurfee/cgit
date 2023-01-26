FROM debian:11-slim

RUN apt update && apt install -y \
    build-essential \
    libssl-dev      \
    zlib1g-dev      \
    git             \
    fcgiwrap        \
    spawn-fcgi      \
    nginx

WORKDIR /build
RUN git clone --depth 1 https://git.zx2c4.com/cgit

WORKDIR /build/cgit
RUN git submodule init && git submodule update
RUN make && make install

COPY cgitrc /etc/cgitrc
COPY nginx.conf /etc/nginx/sites-enabled/default
COPY entrypoint.sh /build/entrypoint.sh

EXPOSE 80

CMD ["/build/entrypoint.sh"]
