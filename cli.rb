#!/usr/bin/env ruby

# Counter application using vault authentication against redis database

# Load redis library
require "redis"

# Load vault library
require "vault"

# Add vault secret engine path as variable for convenience
secret_path = "database/redis"

# Get client_token value from client_token.txt file and remove the last new line character
client_token = File.open("client_token.txt", "r") { |file| file.read }.delete!("\n")

# Estabish connection to vault
Vault.configure do |config| 
  config.address = "http://192.168.56.31:8200"
  config.token = client_token
end

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
