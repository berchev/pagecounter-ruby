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

## How to use this Project
- `git clone https://github.com/berchev/pagecounter-ruby.git` - download the project
- `cd pagecounter-ruby` - change to project directory 
- `vagrant up` - create dev Vagrant environment
- `vagrant status` - will status of all 3 VMs
- `vagrant ssh <VM name>` - establish ssh connection to desired VM (example: vagrant ssh app01)
- Once connected to **app01** change to /vagrant directory: `cd /vagrant`
- `ruby cli.rb` - run the counter

## Testing connection between app01 and db01
- `vagrant ssh app01` - in order to connect to app01
- `redis-cli -h 192.168.56.11 -p 6379 -a georgiman ping` - output of the comand should be `PONG`

## TODO
- [ ] Store password in key/value store in Vault
- [ ] App get the password from key/value store
 
## DONE
- [x] Install Vault to **app01**
- [x] Include Vault VM
- [x] Set password for redis database on VM **db01**
- [x] Make app connecting using hardcoded password
