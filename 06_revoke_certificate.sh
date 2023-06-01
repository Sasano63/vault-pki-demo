#!/bin/bash


export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN=$(cat token.txt)

# revoke via serial number
vault write pki_int/revoke serial_number=$(cat cert_sn.txt)

# tidy up CRL
vault write pki_int/tidy tidy_cert_store=true tidy_revoked_certs=true

# print certificate to CLI to see revocation time
 curl http://127.0.0.1:8200/v1/pki_int/cert/$(cat cert_sn.txt)

