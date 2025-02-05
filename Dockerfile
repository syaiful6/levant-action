FROM debian:bookworm-slim

COPY --from=hashicorp/levant:0.3 /bin/levant /bin/levant

# install openssh to  setup tunnel
RUN set -ex; \
    savedAptMark="$(apt-mark showmanual)" \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    openssh-client

RUN set -ex; \
    groupadd --gid 1000 levant && \
    useradd --uid 1000 --gid levant --shell /bin/bash --create-home levant

COPY entrypoint.sh /github-action-entrypoint.sh

USER levant

ENTRYPOINT ["/github-action-entrypoint.sh"]