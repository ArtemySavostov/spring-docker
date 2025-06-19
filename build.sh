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
sudo apt install docker.io -y
sudo apt install docker-compose -y

sudo groupadd docker 2>/dev/null || true

sudo usermod -aG docker ubuntu

sudo systemctl daemon-reload
sudo systemctl enable docker
sudo systemctl start docker

sleep 15

if sudo systemctl is-active --quiet docker; then
    echo "Docker daemon запущен успешно"
else
    echo "Ошибка: Docker daemon не запущен"
    exit 1
fi

git clone --depth 1 https://github.com/spring-projects/spring-petclinic.git

mv Dockerfile docker-compose.yml  nginx/ ./spring-petclinic/

cd spring-petclinic

echo 'Ready to start build docker'

sudo docker-compose up -d
