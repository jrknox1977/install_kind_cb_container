#!/bin/bash
set -e

# Update ubuntu and install docker.io
sudo apt-get update -y && sudo apt-get install -y docker.io

# Docker Service
sudo systemctl start docker
sudo systemctl status docker
sudo systemctl enable docker

# Add current user to docker group
sudo usermod -aG docker ${USER}

# Install Kind
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.17.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Instal kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version -o json

# (Optional) Add k alias for kubectl (I can't live without this.)
echo "alias k=kubectl" >> ~/.bash_aliases && source ~/.bashrc