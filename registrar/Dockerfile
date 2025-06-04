FROM alpine:latest
RUN apk add --no-cache curl openssl netcat-openbsd
RUN curl -fsS https://hub.infinyon.cloud/install/install.sh | sh -s -- --path /usr/local/bin
COPY register-spu.sh /
RUN chmod +x /register-spu.sh
CMD ["/register-spu.sh"]