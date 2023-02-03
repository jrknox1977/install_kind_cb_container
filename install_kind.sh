#!/bin/bash
set -e

# Update ubuntu and install docker.io
sudo apt-get update -y && sudo apt install -y docker.io

# Docker Service
sudo systemctl start docker
sudo systemctl enable docker

# Install Kind
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.17.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Instal kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version -o json --client

# (Optional) Add k alias for kubectl (I can't live without this.)
echo "alias k=kubectl" >> ~/.bash_aliases && source ~/.bashrc

# Success!
echo "**************************************************"
echo "docker, kind and kubectl installed successfully!"
echo "**************************************************"
echo "Run --> 'sudo usermod -aG docker \${USER}' to add your current user to the docker group"
echo "Run --> 'newgrp docker' to apply the new group to your current session"
echo "Run --> 'kind create cluster --name <CLUSTER_NAME>' to create a cluster."