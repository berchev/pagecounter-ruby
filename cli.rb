#!/usr/bin/env ruby

# Counter application using vault authentication against redis database

# Load redis library
require "redis"

# Load vault library
require "vault"

# Add vault secret engine path as variable for convenience
secret_path = "database/redis"

# Declaring Vault server address
Vault.configure { |config| config.address = "http://192.168.56.31:8200" }


# Get role_id
role_id = File.open("role_id.txt", "r") { |file| file.read }

# Get secret_id 
secret_id = File.open("secret_id.txt", "r") { |file| file.read }

# Login to vault using role_id and secret_id 
login = Vault.auth.approle(
  role_id,
  secret_id,
)

# Extracting token value
#token = login.auth.client_token

# Create new connection to vault server using extracted token value
#vault_server = Vault::Client.new(
#    address: "http://192.168.56.31:8200",
#    token: token
#)

# Get th key/value pair from vault
secret = Vault.logical.read(secret_path)

# Extract the secret value from vault
value = secret.data[:password]

# Defining variable counter -> connection to redis database 
counter = Redis.new(host: "192.168.56.11", port: 6379, db: 1, password: value)

# Create variable number as next counter 
number = counter.incr("1")

# Print the current number
puts number

