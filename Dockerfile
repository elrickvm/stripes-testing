FROM ubuntu:xenial

RUN apt-get -q update && \
    DEBIAN_FRONTEND="noninteractive" apt-get -q install -y \
    -o Dpkg::Options::="--force-confnew"  --no-install-recommends \
    git wget unzip xvfb && \
    apt-get -q clean -y && rm -rf /var/lib/apt/lists/* && \
    rm -f /var/cache/apt/*.bin 

ENV NODEJS_VERSION 6

RUN wget --no-check-certificate --no-cookies https://deb.nodesource.com/setup_${NODEJS_VERSION}.x -O /tmp/node.sh  && \
    chmod +x /tmp/node.sh && \
    sh -c "/tmp/node.sh" && \
    rm -f /tmp/node.sh && \
    apt-get install nodejs && \
    npm install -g yarn && \
    cd /usr/src && \
    git clone https://github.com/wschnrid/folio-ui-test && \
    yarn install

WORKDIR /usr/src/folio-ui-test