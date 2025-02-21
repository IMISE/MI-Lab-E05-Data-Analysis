FROM nginx:1.17.2-alpine

RUN rm /etc/nginx/conf.d/default.conf
COPY app.conf /opt/app.conf
COPY app-ssl.conf /opt/app-ssl.conf

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

