#!/usr/bin/env bash

export VAULT_ADDR='http://0.0.0.0:8200'

# enable new kv secret engine "database" version 1
vault secrets enable -path="database" -version=1 kv

# create secret "redis" 
vault kv put database/redis password=georgiman

# enable approle method
vault auth enable approle

# add new policy relatad to our application
vault policy write cli cli-pol.hcl

# create role with policy attached
vault write auth/approle/role/cli policies="cli"

# generate role_id
vault read auth/approle/role/cli/role-id | grep 'role_id' | awk '{print $2}' > role_id.txt

# generate secret_id
vault write -f auth/approle/role/cli/secret-id | grep 'secret_id '| awk '{print $2}' > secret_id.txt
