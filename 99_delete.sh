#!/bin/bash
export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN=$(cat token.txt)

vault secrets disable pki
vault secrets disable pki_int

rm CA_cert.crt
rm pki_intermediate.csr
rm intermediate.cert.pem
rm cert_sn.txt
rm example.key
rm example.csr
rm example-cn.csr
rm example-cn.key