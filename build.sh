#!/bin/bash
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo apt install docker-compose -y
sudo groupadd docker
grep docker /etc/group
sudo usermod -aG docker ubuntu
newgrp docker
sudo systemctl daemon-reload
sudo systemctl start docker
export PATH=$PATH:/usr/bin
git clone https://github.com/spring-projects/spring-petclinic.git
mv Dockerfile docker-compose.yml  nginx/ ./spring-petclinic/ 
cd spring-petclinic
docker-compose up -d

