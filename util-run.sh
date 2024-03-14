#!/bin/bash

set -ev

(cd fase5-ms-pedido && mvn clean package)

docker compose -f docker-compose.yml up \
    --force-recreate \
    --renew-anon-volumes \
    --build