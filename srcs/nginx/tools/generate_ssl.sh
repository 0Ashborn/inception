#!/bin/bash
set -euo pipefail

CERT_DIR="/etc/ssl"
CERT_NAME="nginx-selfsigned.crt"
CERT_KEY="nginx-selfsigned.key"
DHPARAM="dhparam.pem"
DAYS=365
COUNTRY="MA"
STATE="Benguerir"
LOCALITY="Benguerir"
ORGANIZATION="1337"
ORG_UNIT="IT"
COMMON_NAME="zsaghir.42.fr"
EMAIL="test@zsaghir.42.fr"

mkdir -p "${CERT_DIR}/private"
mkdir -p "${CERT_DIR}/certs"

if [ ! -f "${CERT_DIR}/certs/${CERT_NAME}" ] || [ ! -f "${CERT_DIR}/private/${CERT_KEY}" ]; then
    echo "[nginx] generating self-signed certificate..."
    openssl req -x509 -nodes -newkey rsa:2048 \
        -keyout "${CERT_DIR}/private/${CERT_KEY}" \
        -out "${CERT_DIR}/certs/${CERT_NAME}" \
        -days "${DAYS}" \
        -subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCALITY}/O=${ORGANIZATION}/OU=${ORG_UNIT}/CN=${COMMON_NAME}/emailAddress=${EMAIL}"
else
    echo "[nginx] certificate already exists, skipping generation."
fi

if [ ! -f "${CERT_DIR}/certs/${DHPARAM}" ]; then
    echo "[nginx] generating dhparam (this may take a while)..."
    openssl dhparam -out "${CERT_DIR}/certs/${DHPARAM}" 2048
else
    echo "[nginx] dhparam exists, skipping."
fi

echo "[nginx] Starting nginx..."
exec nginx -g "daemon off;"
