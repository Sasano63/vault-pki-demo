#!/bin/bash
export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN=$(cat token.txt)

# create role that is allowed to issue intermediate certificates
vault write pki_int/roles/example-role \
     allowed_domains="example.com" \
     allow_subdomains=true \
     max_ttl="72h"

vault write pki_int/roles/second-role \
     allowed_domains="test.com" \
     allow_subdomains=true \
     max_ttl="72h"
