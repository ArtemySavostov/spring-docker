#!/bin/bash
wait_for_dpkg() {
  while true; do
    if sudo lsof /var/lib/dpkg/lock-frontend > /dev/null 2>&1; then
      echo "Блокировка dpkg обнаружена. Ожидание..."
      sleep 10
    else
      echo "Блокировка dpkg снята."
      break
    fi
  done
}

sleep 10 


wait_for_dpkg
sudo apt-get update -qq


wait_for_dpkg
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose

sudo groupadd docker

grep docker /etc/group

sudo usermod -aG docker ubuntu

sudo systemctl daemon-reload
sudo systemctl start docker &
sleep 30

export PATH=$PATH:/usr/bin

git clone --depth 1 https://github.com/spring-projects/spring-petclinic.git

mv Dockerfile docker-compose.yml  nginx/ ./spring-petclinic/

cd spring-petclinic

/usr/bin/docker --version

/usr/bin/docker compose version

echo 'Ready to start build docker'
#docker-compose up -d
