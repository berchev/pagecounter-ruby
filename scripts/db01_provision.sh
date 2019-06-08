#!/usr/bin/env bash

# Debug mode enabled
set -x

# Set password to redis
PASSWORD=georgiman

grep -Fxq $PASSWORD /etc/redis/redis.conf || {
  cp /etc/redis/redis.conf /etc/redis/redis.conf.back
  cp /vagrant/conf/redis.conf /etc/redis/redis.conf
  systemctl restart redis-server
}
