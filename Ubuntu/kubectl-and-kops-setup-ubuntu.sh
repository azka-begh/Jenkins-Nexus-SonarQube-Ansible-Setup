#!/bin/bash

# ssh-keygen --> This will be interactive, so this separately

sudo apt install awscli -y

# aws configure  --> Interactive. Do it separately

sudo curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.29.0/2024-01-04/bin/linux/amd64/kubectl
sudo chmod +x ./kubectl
sudo mv ~/bin/kubectl /usr/local/bin/
kubectl version --client

curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
sudo curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x kops
sudo chmod +x kops
sudo mv kops /usr/local/bin/kops
kops version

# nslookup should resolve to 4 ns servers
nslookup -type=ns k8skops.aab12.xyz
