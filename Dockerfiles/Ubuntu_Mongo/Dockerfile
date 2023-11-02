FROM ubuntu:20.04
WORKDIR /app
RUN apt-get update -y && apt-get install curl sudo gnupg -y && \
    curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add - && \
    apt-key list && \
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list && \
    sudo apt update -y && \
    sudo apt install mongodb-org -y && \
    sudo mkdir -p /var/lib/mongo && \
    sudo mkdir -p /var/log/mongodb && \ 
    sudo chown `whoami` /var/lib/mongo && \
    sudo chown `whoami` /var/log/mongodb && \
    apt-get install net-tools && \
    apt-get remove curl gnupg -y

COPY . .
ENTRYPOINT mongod --sslMode requireSSL --sslPEMKeyFile ssl/mongodb.pem --sslCAFile ssl/rootCA.pem --dbpath /var/lib/mongodb/ --logpath /var/log/mongodb/mongod.log > /dev/null --fork  && /bin/bash
