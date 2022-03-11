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

Afther the infra is created, virtual machines DNS names and IPs will be available in the following files
- terraform/routers
- terraform/routers.yml

You can ssh to the virtual machines using:
- username admin
- ssh-keys you configured for AWS

E.g.

`ssh admin@ec2-3-64-7-251.eu-central-1.compute.amazonaws.com`

### Destroy the sandbox
`terraform destroy`
