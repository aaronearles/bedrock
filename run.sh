#!/bin/bash
NEW_IP=$(curl -4 -s ifconfig.io)
sed -i "s|^    ip: .*|    ip: $NEW_IP|" config.yml
docker compose up -d