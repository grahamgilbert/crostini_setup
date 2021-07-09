#!/bin/bash
CURRENTUSER=`logname`
apt install -y lsb-release software-properties-common
# gcloud
# Create environment variable for correct distribution
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"

# Add the Cloud SDK distribution URI as a package source
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

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
   gnupg \
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
   keychain \
   google-cloud-sdk
   
apt install -y --reinstall build-essential

# Install vscode
curl -L -o vscode.deb https://go.microsoft.com/fwlink/?LinkID=760868
dpkg -i vscode.deb
apt install -f -y
rm -f vscode.deb
apt update -y

sudo -u $CURRENTUSER code --install-extension shan.code-settings-sync

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

dpkg -i google-chrome-stable_current_amd64.deb
apt install -fy
dpkg -i google-chrome-stable_current_amd64.deb
rm -f google-chrome-stable_current_amd64.deb


# Terraform time
curl -L -o terraform.zip https://releases.hashicorp.com/terraform/0.15.4/terraform_0.15.4_linux_amd64.zip
unzip terraform.zip
rm terraform.zip
mkdir -p /usr/local/bin
mv terraform /usr/local/bin/terraform


wget https://golang.org/dl/go1.16.4.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.16.4.linux-amd64.tar.gz
rm go1.16.4.linux-amd64.tar.gz


grep -q -F 'eval `keychain --eval --agents ssh id_rsa`
' /home/${CURRENTUSER}/.bashrc
if [ $? -ne 0 ]; then
  echo 'eval `keychain --eval --agents ssh id_rsa`
' >> /home/${CURRENTUSER}/.bashrc
fi

chown ${CURRENTUSER} /home/${CURRENTUSER}/.bashrc

# ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub

git clone https://github.com/tfutils/tfenv.git /home/${CURRENTUSER}/.tfenv
chown -R ${CURRENTUSER} /home/${CURRENTUSER}/.tfenv


grep -qxF 'export PATH=$PATH:/usr/local/go/bin:.tfenv/bin' /home/$CURRENTUSER/.bashrc || echo 'export PATH=$PATH:/usr/local/go/bin:.tfenv/bin' >> /home/$CURRENTUSER/.bashrc
chown ${CURRENTUSER} /home/${CURRENTUSER}/.bashrc

# Python 3.9
if [ ! -f /usr/local/bin/python3.9 ]; then

 wget https://www.python.org/ftp/python/3.9.5/Python-3.9.5.tgz
 tar xvf Python-3.9.5.tgz
 cd Python-3.9.5
 ./configure --enable-optimizations
 make -j8
 make altinstall
fi

rm -rf Python-*

# aws cli
python3.9 -m pip install awscli --upgrade
