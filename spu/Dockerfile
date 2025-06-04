FROM infinyon/fluvio:stable

ENV RUST_LOG=info,fluvio_spu=debug
ENV RAILWAY_RUN_UID=0

EXPOSE 9005 9006

# Start script will handle registration and startup
COPY start-spu.sh /
RUN chmod +x /start-spu.sh
CMD ["/start-spu.sh"]