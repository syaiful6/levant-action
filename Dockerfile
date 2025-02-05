FROM debian:bookworm-slim

COPY --from=hashicorp/levant:0.3 /bin/levant /bin/levant

# install openssh to  setup tunnel
RUN set -ex; \
    savedAptMark="$(apt-mark showmanual)" \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    openssh-client

COPY entrypoint.sh /github-action-entrypoint.sh

ENTRYPOINT ["/github-action-entrypoint.sh"]
