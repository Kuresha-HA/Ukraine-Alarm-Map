FROM nginx:alpine

RUN apk add --no-cache curl

COPY nginx.conf /etc/nginx/nginx.conf
COPY run.sh /run.sh

RUN chmod +x /run.sh

ARG BUILD_VERSION
ARG BUILD_ARCH

LABEL   io.hass.version="$BUILD_VERSION"   io.hass.type="app"   io.hass.arch="$BUILD_ARCH"

CMD ["/run.sh"]
