#!/usr/bin/env ruby

# Counter application using redis database

# Load redis library
require "redis"

# Load vault library
require "vault"

# Add Vault configuration:
Vault.configure do |config|
  config.address = ENV['VAULT_ADDR']
  config.token = ENV['VAULT_TOKEN']
end

# Add vault secret engine path as variable for convenience
secret_path = "database/redis"

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

