# dockurr/macos — web UI on port 8006.
# Dokploy Domains: osx.jobsvue.com → port 8006 → HTTPS on
# Dokploy Advanced (required — Dockerfile cannot set these):
#   Privileged ON | Cap NET_ADMIN | Devices /dev/kvm + /dev/net/tun | Volume → /storage

FROM dockurr/macos:1.14

ENV VERSION=15 \
    DISK_SIZE=256G \
    RAM_SIZE=8G \
    CPU_CORES=1

LABEL traefik.enable="true" \
    traefik.docker.network="dokploy-network" \
    traefik.http.routers.dockerosx-web.rule="Host(`osx.jobsvue.com`)" \
    traefik.http.routers.dockerosx-web.entrypoints="web" \
    traefik.http.routers.dockerosx-web.middlewares="redirect-to-https@file" \
    traefik.http.routers.dockerosx-web.service="dockerosx" \
    traefik.http.routers.dockerosx-websecure.rule="Host(`osx.jobsvue.com`)" \
    traefik.http.routers.dockerosx-websecure.entrypoints="websecure" \
    traefik.http.routers.dockerosx-websecure.tls="true" \
    traefik.http.routers.dockerosx-websecure.tls.certresolver="letsencrypt" \
    traefik.http.routers.dockerosx-websecure.service="dockerosx" \
    traefik.http.services.dockerosx.loadbalancer.server.port="8006"

VOLUME ["/storage"]
