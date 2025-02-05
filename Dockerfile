FROM hashicorp/levant:0.3

COPY entrypoint.sh /github-action-entrypoint.sh

ENTRYPOINT ["/github-action-entrypoint.sh"]
