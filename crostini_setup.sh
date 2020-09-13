#!/bin/bash
# gcloud
# Create environment variable for correct distribution
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"

# Add the Cloud SDK distribution URI as a package source
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list

# Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

wget https://apt.puppet.com/puppet-tools-release-stretch.deb
dpkg -i puppet-tools-release-stretch.deb

# Docker
curl -fsSL https://download.docker.com/linux/debian/gpg |  apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

apt update -y
apt upgrade -y
apt install -y \
   apt-transport-https \
   ca-certificates \
   curl \
   software-properties-common \
   make \
   gnome-terminal \
   build-essential \
   libssl-dev \
   zlib1g-dev \
   libbz2-dev \
   libreadline-dev \
   libsqlite3-dev \
   keychain \
   wget \
   llvm \
   libncurses5-dev \
   libncursesw5-dev \
   xz-utils \
   tk-dev \
   python3.7 \
   nano \
   fonts-hack-ttf \
   pdk \
   docker-ce \
   gcc \
   google-cloud-sdk
   
apt install --reinstall build-essential

# Install vscode
curl -L -o vscode.deb https://go.microsoft.com/fwlink/?LinkID=760868
dpkg -i vscode.deb
apt install -f -y
rm -f vscode.deb
apt update -y

code --install-extension shan.code-settings-sync

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

dpkg -i google-chrome-stable_current_amd64.deb
apt install -fy
dpkg -i google-chrome-stable_current_amd64.deb
rm -f google-chrome-stable_current_amd64.deb


# Terraform time
curl -L -o terraform.zip https://releases.hashicorp.com/terraform/0.12.25/terraform_0.12.25_linux_amd64.zip
unzip terraform.zip
rm terraform.zip
mkdir -p /usr/local/bin
mv terraform /usr/local/bin/terraform


wget https://dl.google.com/go/go1.14.3.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.14.3.linux-amd64.tar.gz
rm go1.14.3.linux-amd64.tar.gz

USER=`logname`
grep -q -F 'eval `keychain --eval --agents ssh id_rsa`
' /home/${USER}/.bashrc
if [ $? -ne 0 ]; then
  echo 'eval `keychain --eval --agents ssh id_rsa`
' >> /home/${USER}/.bashrc
fi

chown ${SUDO_USER} /home/${USER}/.bashrc

# ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub

grep -qxF 'export PATH=$PATH:/usr/local/go/bin' /home/$USER/.bashrc || echo 'export PATH=$PATH:/usr/local/go/bin' >> /home/$USER/.bashrc

# Python 3.8
if [ ! -f /usr/local/bin/python3.8 ]; then

 wget https://www.python.org/ftp/python/3.8.3/Python-3.8.3.tgz
 tar xvf Python-3.8.3.tgz
 cd Python-3.8.3
 ./configure --enable-optimizations
 make -j8
 make altinstall
fi

rm -rf Python-*

# aws cli
python3.8 -m pip install awscli --upgrade
