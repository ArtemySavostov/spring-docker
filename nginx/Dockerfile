FROM nginx:latest

# Установка Certbot и зависимостей
RUN apt-get update && \
    apt-get install -y \
    certbot \
    python3-certbot-nginx \
    cron \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Копирование конфигурации
COPY conf.d/default.conf /etc/nginx/conf.d/default.conf

# Копирование скрипта автоматизации Certbot
COPY certbot-entrypoint.sh /docker-entrypoint.d/

# Создание необходимых директорий
RUN mkdir -p /var/www/html && \
    mkdir -p /etc/letsencrypt && \
    chmod +x /docker-entrypoint.d/certbot-entrypoint.sh

# Настройка cron для автоматического обновления сертификатов
RUN echo "0 12 * * * /usr/bin/certbot renew --quiet --nginx" | crontab -

# Открытие портов
EXPOSE 80 443

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1
