#!/bin/bash
NEW_IP=$(curl -4 -s ifconfig.io)
sed -i "s|^    ip: .*|    ip: $NEW_IP|" config.yml
docker compose -f /bedrock/docker-compose.yml up -d
sleep 30
MSG=$(docker compose -f /bedrock/docker-compose.yml logs mcxboxbroadcast | grep -i microsoft.com/link | tail -n 1 | sed 's/.*\[Auth] //; s/\].*//')
curl -d "$MSG" ntfy.sh/aearles_alerts