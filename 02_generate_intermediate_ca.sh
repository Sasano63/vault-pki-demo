#!/bin/bash
set -o xtrace

export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN=$(cat token.txt)

vault secrets enable -path=pki_int pki
vault secrets tune -max-lease-ttl=4380h pki_int

 # generate Intermediate CA and save CSR
vault write -format=json pki_int/intermediate/generate/internal \
     common_name="example.com Intermediate Authority" \
     | jq -r '.data.csr' > pki_intermediate.csr

# sign int CA with root CA private key
vault write -format=json pki/root/sign-intermediate csr=@pki_intermediate.csr \
     format=pem_bundle ttl="4380h" \
     | jq -r '.data.certificate' > intermediate.cert.pem

# import int CA back to Vault
vault write pki_int/intermediate/set-signed certificate=@intermediate.cert.pem 
