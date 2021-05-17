#!/bin/bash

ROOT_DIR=$1
TF_VERSION='0.15.3'
DEPLOY_DIR="${ROOT_DIR}/terraform"

echo "Installing build dependencies..."
apt-get -qq update
apt-get -qq upgrade -y
apt-get -qq install -y git curl unzip

echo "Installing tfenv from https://github.com/tfutils/tfenv..."
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
ln -s ~/.tfenv/bin/* /usr/local/bin > /dev/null

echo "Install Terraform v${TF_VERSION} using tfenv:"
tfenv install ${TF_VERSION} > /dev/null
tfenv use ${TF_VERSION}

echo "Applying Terraform from ${DEPLOY_DIR}"
cd ${DEPLOY_DIR}
terraform init
terraform validate
terraform apply -auto-approve
