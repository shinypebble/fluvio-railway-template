FROM infinyon/fluvio:stable

EXPOSE 9005 9006

# Start script will handle registration and startup
COPY start-spu.sh /
RUN chmod +x /start-spu.sh
CMD ["/start-spu.sh"]