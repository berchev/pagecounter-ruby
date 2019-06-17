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
| clinet-id-factory.sh | vault server configuration script |

## Description
**app01**(cli.rb) will authenticate against **db01**(redis) using approle vault token, provided by **vault01**(vault server)

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
- `cd /vagrant` - change to /vagrant directory
- `export VAULT_DEV_ROOT_TOKEN_ID=changeme` - set ENV variable **changeme**, which is going to be default root token when Vault server is started
- `vault server -dev -dev-listen-address 0.0.0.0:8200` - start Vault server in dev mode, listening on all IP addresses
- connect to vault server from another terminal
- `cd /vagrant` - change to /vagrant directory
- `bash scripts/clinet-id-factory.sh` - this script is going to configure your vault server (add kv secret engine version 1, add secret, enable approle, generate role_id and secret_id, generate client_token)

## Run Counter
- open another terminal for our app01 machine
- `vagrant ssh app01` - in order to connect to app01
- `cd /vagrant` - change to /vagrant directory
- `ruby cli.rb` - in order to run ruby counter

## TODO


## DONE
- [x] Install Vault to **app01**
- [x] Include Vault VM
- [x] Set password for redis database on VM **db01**
- [x] Make app connecting using hardcoded password
- [x] Store password in key/value store in Vault- [ ] Useapprole
- [x] Useapprole
- [x] Create new token, and use it in order to take Redis password (do NOT use root token)
