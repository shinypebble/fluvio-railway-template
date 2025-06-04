FROM rust:alpine AS builder
RUN apk add --no-cache musl-dev openssl-dev
RUN cargo install fluvio --version 0.17.3

FROM alpine:latest
RUN apk add --no-cache openssl netcat-openbsd
COPY --from=builder /usr/local/cargo/bin/fluvio /usr/local/bin/fluvio
COPY register-spu.sh /
RUN chmod +x /register-spu.sh
CMD ["/register-spu.sh"]