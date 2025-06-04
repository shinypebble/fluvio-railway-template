FROM infinyon/fluvio:stable

ENV RUST_LOG=info,fluvio_sc=debug

ENV FLUVIO_SC_PUBLIC_HOST=::
ENV FLUVIO_SC_PRIVATE_HOST=::

EXPOSE 9003 9004

CMD ["./fluvio-run", "sc", "--bind-public", "[::]:9003", "--bind-private", "[::]:9004", "--local", "/fluvio/metadata"]