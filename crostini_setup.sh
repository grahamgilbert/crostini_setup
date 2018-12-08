#!/bin/bash
apt update -y
apt install -y \
   apt-transport-https \
   ca-certificates \
   curl \
   software-properties-common \
   make \
   build-essential \
   libssl-dev \
   zlib1g-dev \
   libbz2-dev \
   libreadline-dev \
   libsqlite3-dev \
   wget \
   llvm \
   libncurses5-dev \
   libncursesw5-dev \
   xz-utils \
   tk-dev \
   python

# Install vscode
curl -L -o vscode.deb https://go.microsoft.com/fwlink/?LinkID=760868
dpkg -i vscode.deb
apt install -f -y
rm -f vscode.deb
apt update -y

# Install Hack font
apt install -y fonts-hack-ttf

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

dpkg -i google-chrome-stable_current_amd64.deb
apt-get install -f
dpkg -i google-chrome-stable_current_amd64.deb
rm -f google-chrome-stable_current_amd64.deb

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
git clone git@github.com:abiosoft/crostini-docker.git /tmp/crostini-docker
cd /tmp/crostini-docker
./install.sh

# aws cli
pip install awscli --upgrade

# glocoud
# Create environment variable for correct distribution
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"

# Add the Cloud SDK distribution URI as a package source
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list

# Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

# Update the package list and install the Cloud SDK
apt update && apt install -y google-cloud-sdk

grep -q -F 'if [ -z "$SSH_AUTH_SOCK" ] ; then eval `ssh-agent -s` && ssh-add; fi' ~/.bashrc
if [ $? -ne 0 ]; then
  echo 'if [ -z "$SSH_AUTH_SOCK" ] ; then eval `ssh-agent -s` && ssh-add; fi' >> ~/.bashrc
fi

# Python 3.7
if [ ! -f /usr/local/bin/python3.7 ]; then

 wget https://www.python.org/ftp/python/3.7.1/Python-3.7.1.tgz
 tar xvf Python-3.7.1.tgz
 cd Python-3.7.1
 ./configure --enable-optimizations
 make -j8
 make altinstall
fi

rm -rf Python-3.7.1*
