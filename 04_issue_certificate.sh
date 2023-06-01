#!/bin/bash

export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN=$(cat token.txt)

# issue certificate and retrieve serial number
vault write -format=json pki_int/issue/example-role common_name="test.example.com" ttl="24h" \
 | jq -r '.data.serial_number' > cert_sn.txt

vault write -format=json pki_int/issue/example-role common_name="test.example.com" ttl="24h"

# requesting certificate with not allowed CN
vault write -format=json pki_int/issue/second-role common_name="test.example.com" ttl="24h"