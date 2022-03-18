# Ansible-related details

## Note
If you work in the devcontainer, you don't need to install Ansible or other tools and dependencies. They are already installed.

## Prerequisites
SSH access to the virtual machines (see the terraform README for details).

## Start
`cd ansible`

`ansible-playbook play.yml`

## Inventory
AWS EC2 dynamic inventory is used. Read more about it: 
### Docs
`ansible-doc -t inventory aws_ec2`

## Useful commands

### Test if the setup works
#### All virtual machines
`ansible all -m ping`

#### router1
`ansible tag_Name_router1 -m ping`

### Get facts and info, on which Ansible operates, for router1
`ansible tag_Name_router1 -m ansible.builtin.setup`

### Inventory
`ansible-inventory --graph`

`ansible-inventory --list`
