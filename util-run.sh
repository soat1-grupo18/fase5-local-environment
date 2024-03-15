#!/bin/bash

set -ev

(
    cd fase5-ms-pedido \
    && git pull origin main \
    && mvn clean package -DskipTests
)

docker compose -f docker-compose.yml up \
    --force-recreate \
    --renew-anon-volumes \
    --build