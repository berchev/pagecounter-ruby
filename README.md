# pagecounter-ruby
This repo represents dev environment with 3 VMs
- **app01** - representing our counter
- **db01**  - representing our Database (where counter state has been saved)
- **vault01** - representing our Vault server

## Requirements
- [Virtualbox installed](https://www.virtualbox.org/)
- [Vagrant installed](https://www.vagrantup.com/intro/getting-started/install.html)

## Repo content
| File                   | Description                      |
|         ---            |                ---               |
| conf/redis.conf | redis configuration |
| scripts/app01_provision.sh | provision script for app01 VM |
| scripts/db01_provision.sh | provision script for db01 VM |
| scripts/vault01_provision.sh | provision script for vault01 VM |
| Vagrantfile | Vagrant configuration file |
| cli.rb | ruby application - counter |

## Description
**app01**(cli.rb) will authenticate against **db01**(redis) using vault token, provided by **vault01**(vault server)

## Setup dev environment
- `git clone https://github.com/berchev/pagecounter-ruby.git` - download the project
- `cd pagecounter-ruby` - change to project directory 
- `vagrant up` - create dev Vagrant environment
- `vagrant status` - will status of all 3 VMs
- `vagrant ssh <VM name>` - establish ssh connection to desired VM (example: vagrant ssh app01)

## Testing connection between app01 and db01
- `vagrant ssh app01` - in order to connect to app01
- `redis-cli -h 192.168.56.11 -p 6379 -a georgiman ping` - output of the comand should be `PONG`

## Vault setup
- `vagrant ssh vault01` - connect to vault01 machine
- `export VAULT_DEV_ROOT_TOKEN_ID=changeme` - set ENV variable **changeme**, which is going to be default root token when Vault server is started
- `vault server -dev -dev-listen-address 0.0.0.0:8200` - start Vault server in dev mode, listening on all IP addresses
- connect to vault server from another terminal
- `export VAULT_ADDR='http://0.0.0.0:8200'` - export vault server address
- `vault secrets enable -path="database" -version=1 kv` - create secret kv engine with path database version 1 (vault gem is working with version 1)
- `vault kv put database/redis password=georgiman` - write secret redis with key-value pair password=georgiman (in short creating password georgiman for our database)

## Run Counter
- open another terminal for our app01 machine
- `vagrant ssh app01` - in order to connect to app01
- `export VAULT_ADDR="http://192.168.56.31:8200"` - export Vault address as ENV variable
- `export VAULT_TOKEN="changeme"` - export Vault root token as ENV variable
- `ruby cli.rb` - in order to run ruby counter 

## TODO
- [ ] Create new token, and use it in order to take Redis password (do NOT use root token)
- [ ] Create token with TTL (time to live)
- [ ] Use dynamic secrets
 
## DONE
- [x] Install Vault to **app01**
- [x] Include Vault VM
- [x] Set password for redis database on VM **db01**
- [x] Make app connecting using hardcoded password
- [x] Store password in key/value store in Vault
- [x] App get the password from key/value store
