#!/bin/bash

mkdir ~/install

# Resize EBS in AWS Cloud9 environment 
cd ~/install
wget 'https://ws-assets-prod-iad-r-iad-ed304a55c2ca1aee.s3.us-east-1.amazonaws.com/76bc5278-3f38-46e8-b306-f0bfda551f5a/shared/resize.sh' 
bash resize.sh 20

# Install Python 3.9
cd ~/install
#wget 'https://www.python.org/ftp/python/3.9.10/Python-3.9.10.tgz'
#echo 'Extracting Python 3.9...'
#tar xvf Python-3.9.10.tgz > /dev/null 2>&1
#cd Python-*/
#./configure --enable-optimizations
#sudo make altinstall
# Set Python 3.9 as the default
#alias python="python3.9"
#echo -e 'alias python="python3.9" ' >> ~/.bashrc 

sudo yum install -y python3 python3-pip
alias python=python3
echo -e 'alias python=python3' >> ~/.bashrc
echo 'Python 3.9 installed!'

# Upgrade to latest version of AWS SAM 
cd ~/install
wget 'https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip'
unzip aws-sam-cli-linux-x86_64.zip -d sam-installation
sudo ./sam-installation/install --update

# Upgrade to latest AWS CLI version
cd ~/install
wget https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
unzip awscli-exe-linux-x86_64.zip
sudo ./aws/install --update

# Install Python libraries
python3.9 -m pip install --upgrade pip
python3.9 -m pip install aws-lambda-powertools
python3.9 -m pip install boto3 
python3.9 -m pip install numpy

# Return to the environment directory where we started
cd ~/environment
pwd
echo 'Setup complete!'
