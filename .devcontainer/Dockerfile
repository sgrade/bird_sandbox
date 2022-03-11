# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.217.4/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version (use hirsuite or bionic on local arm64/Apple Silicon): hirsute, focal, bionic
ARG VARIANT="hirsute"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

###
# Extra configuration in addition to what was defined in the Microsoft template above
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends curl unzip

# Ansible - https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-with-pip
RUN apt-get -y install python3-distutils
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3 get-pip.py
RUN python3 -m pip install ansible

# The ipaddr filter requires python's netaddr be installed on the ansible controller
RUN python3 -m pip install netaddr

# AWS EC2 inventory source. 
# https://docs.ansible.com/ansible/latest/collections/amazon/aws/aws_ec2_inventory.html
# The ec2 dynamic inventory plugin requires boto3 and botocore.
RUN python3 -m pip install boto3
RUN python3 -m pip install botocore

# AWS CLI
RUN curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
  && unzip awscliv2.zip \
  && ./aws/install \
  && rm -rf aws awscliv2.zip
