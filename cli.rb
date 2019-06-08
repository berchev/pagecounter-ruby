#!/usr/bin/env ruby

# Counter application using redis database

# Load redis library
require "redis"

# Create variable counter as new redis connection
counter = Redis.new(host: "192.168.56.11", port: 6379, db: 1, password: "georgiman")


# Create variable number as next counter 
number = counter.incr("1")

# Print the current number
puts number
