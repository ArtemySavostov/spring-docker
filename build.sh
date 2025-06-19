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

# Создаем группу docker если её нет
sudo groupadd docker 2>/dev/null || true

# Добавляем пользователя ubuntu в группу docker
sudo usermod -aG docker ubuntu

# Перезапускаем Docker daemon
sudo systemctl daemon-reload
sudo systemctl enable docker
sudo systemctl start docker

# Ждем запуска Docker daemon
sleep 10

# Проверяем что Docker запущен
sudo systemctl status docker

# Переключаемся на пользователя ubuntu для работы с Docker
sudo -u ubuntu docker --version
sudo -u ubuntu docker-compose version

git clone --depth 1 https://github.com/spring-projects/spring-petclinic.git

mv Dockerfile docker-compose.yml  nginx/ ./spring-petclinic/

cd spring-petclinic

echo 'Ready to start build docker'
sudo -u ubuntu docker-compose up -d
