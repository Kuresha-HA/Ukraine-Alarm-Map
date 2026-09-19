FROM nginx:alpine
RUN apk add --no-cache curl
COPY nginx.conf /etc/nginx/nginx.conf
COPY run.sh /run.sh
RUN chmod +x /run.sh
CMD ["/run.sh"]
