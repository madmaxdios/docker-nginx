#!/bin/sh
set -e

# Create directories
mkdir -p nginx/certs

# Generate root CA
openssl genrsa -out nginx/certs/rootCA.key 4096
openssl req -x509 -new -nodes -key nginx/certs/rootCA.key -sha256 -days 1024 -out nginx/certs/rootCA.crt \
    -subj "//C=ES/O=Local Development/CN=Local Development Root CA"

# Generate domain key
openssl genrsa -out nginx/certs/localhost.key 2048

# Create CSR config
cat > nginx/certs/localhost.conf << EOF
[req]
default_bits = 2048
prompt = no
default_md = sha256
distinguished_name = dn
req_extensions = req_ext

[dn]
C=ES
O=Local Development
CN=localhost

[req_ext]
subjectAltName = @alt_names

[alt_names]
DNS.1 = localhost
DNS.2 = *.localhost
IP.1 = 127.0.0.1
EOF

# Generate CSR
openssl req -new -key nginx/certs/localhost.key \
    -out nginx/certs/localhost.csr \
    -config nginx/certs/localhost.conf

# Generate certificate
openssl x509 -req -in nginx/certs/localhost.csr \
    -CA nginx/certs/rootCA.crt \
    -CAkey nginx/certs/rootCA.key \
    -CAcreateserial \
    -out nginx/certs/localhost.crt \
    -days 365 \
    -sha256 \
    -extensions req_ext \
    -extfile nginx/certs/localhost.conf

# Set permissions
chmod 644 nginx/certs/localhost.crt nginx/certs/rootCA.crt
chmod 600 nginx/certs/localhost.key nginx/certs/rootCA.key

echo "Certificates generated successfully!"