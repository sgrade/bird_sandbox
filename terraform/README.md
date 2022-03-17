# Terraform-related details

## Note
If you work in the devcontainer, you don't need to install AWS CLI or terraform. They are already installed.

## Prerequisites
AWS [programmatic access](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys).

SSH key to connect to the virtual machines. Change the key_name in variables.tf if your key name is not "default-key".

## Start
`cd terraform`

## First run only
`terraform init`

## All runs
### Create the sandbox in AWS
`terraform plan`

`terraform apply`

Afther the apply is complete, virtual machines DNS names and IPs will be available in the following files
- terraform/routers
- terraform/routers.yml

You can ssh to the virtual machines using:
- username admin
- ssh-keys you configured for AWS

E.g.

`ssh admin@ec2-3-64-7-251.eu-central-1.compute.amazonaws.com`

### Destroy the sandbox
`terraform destroy`

## Useful commands
### Print the output
`terraform output`

### Re-create Virtual Machines
#### One VM
The AWS EC2 VM-s are [zero-indexed](https://en.wikipedia.org/wiki/Zero-based_numbering), but in the sandbox they are one-indexed. 

E.g., to re-create router1, you use index 0 in the following command:

`terraform apply -replace="aws_instance.router[0]"`

The one-based indices are used for easier matching with the IP addresses: .0 IP address usually cannot be assigned to a host.

#### All VMs
`terraform apply -replace="aws_instance.router"`
