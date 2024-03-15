#!/bin/bash

set -ev

(
    cd fase5-ms-pedido \
    && git pull origin main \
    && mvn clean package -DskipTests
)

(
    cd fase5-ms-pagamento \
    && git pull origin main \
    && mvn clean package -DskipTests
)

(
    cd fase5-ms-cliente \
    && git pull origin main \
    && mvn clean package -DskipTests
)

docker compose -f docker-compose.yml up -d \
    --force-recreate \
    --renew-anon-volumes \
    --build