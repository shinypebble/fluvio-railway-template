FROM infinyon/fluvio:stable

EXPOSE 9003 9004

CMD ["./fluvio-run", "sc", "--bind-public", "[::]:9003", "--bind-private", "[::]:9004", "--local", "/fluvio/metadata"]