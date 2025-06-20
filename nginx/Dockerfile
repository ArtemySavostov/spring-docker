FROM nginx:latest
RUN apt-get update && apt-get install -y certbot python3-certbot-nginx
COPY conf.d/default.conf /etc/nginx/conf.d/default.conf
COPY certbot-entrypoint.sh /docker-entrypoint.d/
RUN mkdir -p /var/www/html && \
    chmod +x /docker-entrypoint.d/certbot-entrypoint.sh
