# Spring PetClinic - Docker & Cloud Deployment с SSL

Полноценное Spring Boot приложение с автоматизированным развертыванием в облаке Yandex Cloud с использованием Docker, Terraform и **автоматической настройкой SSL сертификатов через Nginx + Certbot + Let's Encrypt**.

## Главная цель проекта

Основная задача этого проекта - демонстрация **автоматической настройки SSL/TLS сертификатов** для веб-приложений в облачной среде. Проект включает:

- **Nginx** как reverse proxy и веб-сервер
- **Certbot** для автоматического получения SSL сертификатов от Let's Encrypt
- **Let's Encrypt** для бесплатных SSL сертификатов


## Быстрый старт

### Локальный запуск

1. **Клонируйте репозиторий:**
```bash
git clone https://github.com/ArtemySavostov/spring-docker.git
cd spring-docker
```

2. **Запустите приложение:**
```bash
chmod +x build.sh
./build.sh
```

3. **Откройте приложение:**
- HTTP: http://localhost:80/
- HTTPS: https://localhost/ (с самоподписанным сертификатом)

### Развертывание в облаке с SSL

1. **Настройте домен:**
```bash
# Укажите ваш домен в nginx/conf.d/default.conf
server_name your-domain.com www.your-domain.com;
```

2. **Разверните в Yandex Cloud:**
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

3. **Автоматическая настройка SSL:**
После развертывания Certbot автоматически:
- Получит SSL сертификат от Let's Encrypt
- Настроит Nginx для HTTPS

## SSL/TLS Конфигурация

### Автоматическая настройка SSL

Проект автоматически настраивает SSL сертификаты:

1. **Certbot автоматически получает сертификаты:**
```bash
certbot certonly --webroot -w /var/www/html -d your-domain.com
```

## Компоненты системы

### 1. Spring Boot Приложение
- **Технологии:** Spring Boot, Spring Data JPA, MySQL
- **Порт:** 8080 (внутренний)
- **Профиль:** mysql
- **База данных:** MySQL 9.1

### 2. Terraform Инфраструктура
- **Провайдер:** Yandex Cloud
- **Ресурсы:** VPC, подсеть, VM Ubuntu
- **Автоматизация:** Remote-exec provisioner для развертывания

### 3. Docker Контейнеризация
- **Сервисы:** 
  - `petclinic` - MySQL база данных
  - `app` - Spring Boot приложение
  - `nginx` - Веб-сервер с SSL и прокси
- **Сеть:** Docker Compose network

### 4. Nginx + Certbot + Let's Encrypt
- **Проксирование:** Приложение на порту 8080
- **SSL:** Автоматические сертификаты Let's Encrypt
- **HTTP/2:** Поддержка современного протокола



### SSL конфигурация
- **Домен:** Укажите в nginx/conf.d/default.conf
- **Email:** Для уведомлений Let's Encrypt

## Требования

### Для локального запуска:
- Docker
- Docker Compose
- Git

### Для облачного развертывания:
- Terraform >= 0.13
- Yandex Cloud CLI
- SSH ключи для доступа к VM
- **Домен с настроенным DNS** (для SSL)


