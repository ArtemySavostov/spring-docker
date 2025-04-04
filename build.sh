#!/bin/bash
git clone https://github.com/spring-projects/spring-petclinic.git
mv Dockerfile docker-compose.yml  nginx/ ./spring-petclinic/ 
cd spring-petclinic
docker-compose up -d

