#!/bin/bash
set -eu

ENVIRONMENT="${1:?Uso: ./deploy.sh dev|qa|prod}"

case "$ENVIRONMENT" in
  dev)
    export PORT_FRONT=8081
    export PORT_BACK=8084
    ;;
  qa)
    export PORT_FRONT=8082
    export PORT_BACK=8083
    ;;
  prod)
    export PORT_FRONT=80
    export PORT_BACK=5000
    ;;
  *)
    echo "Ambiente inválido: $ENVIRONMENT" >&2
    exit 2
    ;;
esac

echo "Desplegando ambiente $ENVIRONMENT en Frontend: $PORT_FRONT, Backend: $PORT_BACK..."

# Tumbar contenedores previos del ambiente y volver a levantar
PORT_FRONT=$PORT_FRONT PORT_BACK=$PORT_BACK docker compose -p "app-$ENVIRONMENT" down
PORT_FRONT=$PORT_FRONT PORT_BACK=$PORT_BACK docker compose -p "app-$ENVIRONMENT" up -d --build
