#!/bin/bash

check_lock() {
  while fuser /var/lib/dpkg/lock >/dev/null 2>&1 || fuser /var/lib/apt/lists/lock >/dev/null 2>&1 || fuser /var/cache/apt/archives/lock >/dev/null 2>&1; do
    echo "Блокировка менеджера пакетов обнаружена. Ожидание..."
    sleep 10
  done
}

sleep 10

check_lock
sudo apt-get update -qq

check_lock
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose

sudo groupadd docker
grep docker /etc/group
sudo usermod -aG docker ubuntu
newgrp docker

sudo systemctl daemon-reload
sudo systemctl start docker & 
sleep 30 

export PATH=$PATH:/usr/bin
git clone --depth 1 https://github.com/spring-projects/spring-petclinic.git

mv Dockerfile docker-compose.yml  nginx/ ./spring-petclinic/
cd spring-petclinic

docker --version
docker-compose version

echo 'Ready to start build docker'
#docker-compose up -d
