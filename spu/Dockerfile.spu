FROM infinyon/fluvio:stable

ENV RUST_LOG=info,fluvio_spu=debug
ENV RAILWAY_RUN_UID=0

EXPOSE 9010 9011

# Start script will handle registration and startup
COPY start-spu.sh /
RUN chmod +x /start-spu.sh
CMD ["/start-spu.sh"]