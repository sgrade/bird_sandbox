# Ansible-related details

## Note
If you work in the devcontainer, you don't need to install Ansible or other tools and dependencies. They are already installed.

## Prerequisites
SSH access to the virtual machines (see terraform for details).

## Start
`cd ansible`
`ansible-playbook play.yml`

## Inventory
AWS EC2 dynamic inventory is used. Below are some commands to get used to it.

`ansible tag_Name_router1 -m ping`
`ansible-inventory --graph`
`ansible-inventory --list`
`ansible-doc -t inventory  aws_ec2`
