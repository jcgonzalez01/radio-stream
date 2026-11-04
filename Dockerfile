FROM debian:bookworm-slim

RUN apt-get update \
 && apt-get install -y --no-install-recommends icecast2 gettext-base ca-certificates curl mime-support \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /var/log/icecast2 /etc/icecast2 \
 && chown -R icecast2:icecast /var/log/icecast2 /etc/icecast2

COPY icecast.xml.template /etc/icecast2/icecast.xml.template
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV ICECAST_SOURCE_PASSWORD=cambiame-source \
    ICECAST_RELAY_PASSWORD=cambiame-relay \
    ICECAST_ADMIN_USER=admin \
    ICECAST_ADMIN_PASSWORD=cambiame-admin \
    ICECAST_HOSTNAME=localhost \
    ICECAST_LOCATION=Earth \
    ICECAST_ADMIN_EMAIL=admin@localhost \
    ICECAST_MAX_CLIENTS=100 \
    ICECAST_ALLOWED_ORIGIN=*

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s \
  CMD curl -fs http://localhost:8000/status-json.xsl >/dev/null || exit 1

USER icecast2
ENTRYPOINT ["/entrypoint.sh"]
