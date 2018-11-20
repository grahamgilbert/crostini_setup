#!/bin/bash
apt update -y
apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Install vscode
curl -L -o vscode.deb https://go.microsoft.com/fwlink/?LinkID=760868
dpkg -i vscode.deb
apt install -f -y
rm -f vscode.deb
apt update -y

# Install Hack font
apt install -y fonts-hack-ttf

# Terraform time
curl -L -o terraform.zip https://releases.hashicorp.com/terraform/0.11.10/terraform_0.11.10_linux_amd64.zip
unzip terraform.zip
rm terraform.zip
mkdir -p /usr/local/bin
mv terraform /usr/local/bin/terraform

# Docker
curl -fsSL https://download.docker.com/linux/debian/gpg |  apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
apt update -y
apt install -y docker-ce
# if ssh key isn't here exit and tell person to copy it to place
