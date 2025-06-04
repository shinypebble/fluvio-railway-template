FROM alpine:latest

RUN apk add --no-cache curl openssl netcat-openbsd bash
RUN curl -fsS https://hub.infinyon.cloud/install/install.sh | bash
ENV PATH="/root/.fvm/bin:/root/.fluvio/bin:${PATH}"

COPY register-spu.sh /
RUN chmod +x /register-spu.sh
CMD ["/register-spu.sh"]