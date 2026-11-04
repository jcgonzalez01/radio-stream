#!/bin/sh
set -e

# El usuario icecast2 puede escribir en /etc/icecast2 (ver Dockerfile)
envsubst < /etc/icecast2/icecast.xml.template > /etc/icecast2/icecast.xml

exec icecast2 -c /etc/icecast2/icecast.xml
