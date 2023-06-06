#!/bin/bash
export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN=$(cat token.txt)

vault secrets enable pki

#default ttl 30 days, for root CA a bit short -> set to one year
vault secrets tune -max-lease-ttl=8760h pki

# generate root certificate
vault write -field=certificate pki/root/generate/internal \
     common_name="example.com" \
     ttl=8760h > CA_cert.crt
     
#url setzen
vault write pki/config/urls \
     issuing_certificates="$VAULT_ADDR/v1/pki/ca" \
     crl_distribution_points="$VAULT_ADDR/v1/pki/crl"
