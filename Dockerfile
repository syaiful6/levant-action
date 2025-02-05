FROM debian:bookworm-slim

COPY --from=hashicorp/levant:0.3 /bin/levant /bin/levant

RUN set -ex; \
    groupadd --gid 1000 levant && \
    useradd --uid 1000 --gid levant --shell /bin/bash --create-home levant

COPY entrypoint.sh /github-action-entrypoint.sh

USER levant

ENTRYPOINT ["/github-action-entrypoint.sh"]