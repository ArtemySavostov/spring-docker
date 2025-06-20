FROM nginx:latest

RUN apt-get update && apt-get install -y \
    certbot \
    python3-certbot-nginx \
    cron \
    && rm -rf /var/lib/apt/lists/*

COPY conf.d/default.conf /etc/nginx/conf.d/default.conf

COPY certbot-entrypoint.sh /docker-entrypoint.d/

RUN mkdir -p /var/www/html && \
    chmod +x /docker-entrypoint.d/certbot-entrypoint.sh

RUN echo "0 12 * * * /usr/bin/certbot renew --quiet --nginx" | crontab -

EXPOSE 80 443
