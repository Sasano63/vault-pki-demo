#!/bin/bash
set -o xtrace
export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN=$(cat token.txt)

# create CSR that complies with role
openssl req -nodes -newkey rsa:2048 -keyout example.key -out example.csr -subj "/C=DE/ST=Berlin/L=Berlin/O=Global Security/OU=IT Department/CN=test.example.com"

# have CSR signed by Vault
vault write -format=json pki_int/sign/example-role csr="$(cat example.csr)" ttl="24h"

# create CSR with disallowed common name
openssl req -nodes -newkey rsa:2048 -keyout example-cn.key -out example-cn.csr -subj "/C=DE/ST=Berlin/L=Berlin/O=Global Security/OU=IT Department/CN=example.com"

# try signing with disallowed common name
vault write -format=json pki_int/sign/example-role csr="$(cat example-cn.csr)" ttl="24h"