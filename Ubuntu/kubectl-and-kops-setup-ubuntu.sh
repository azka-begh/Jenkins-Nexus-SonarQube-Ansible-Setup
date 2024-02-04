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

# Do not use t2 instances
kops create cluster --name=k8skops.aab12.xyz --state=s3://kops-s3-k8s-bucket --zones=us-east-2a,us-east-2b --node-count=2 --node-size=t3.small --control-plane-size=t3.medium --dns-zone=k8skops.aab12.xyz --node-volume-size=8 --control-plane-volume-size=8
kops update cluster --name k8skops.aab12.xyz --yes --state=s3://kops-s3-k8s-bucket --yes --admin
# Wait for 15 min atleast and run:
kops validate cluster --state=s3://kops-s3-k8s-bucket
# For retrying until 10min use --wait 10m option with validate
--------------------------------------------------------------------
# To get nodes in the cluster 
export KOPS_STATE_STORE=s3://kops-s3-k8s-bucket
kops get ig

# edit your master and slave nodes
kops edit ig <master-name>

# Change maxsize and minsize to 0

minsize: 0
maxSize: 0

# Update your cluster

kops update cluster --yes
# Rolling changes to stop the cluster

kops rolling-update cluster --yes
# Rolling changes to start the cluster

kops rolling-update cluster --cloudonly --force --yes
---------------------------------------------------------------------
# Delete the cluster
 kops delete cluster --name=k8skops.aab12.xyz --state=s3://kops-s3-k8s-bucket --yes
