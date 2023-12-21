#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
mkdir -p ~/ansible/

#When ansible is installed, then go to /etc/ansible/ and take a backup of ansible.cfg 
#and run ansible-config init --disabled -t all > ansible.cfg
#or simple create an ansible.config file in your working ansible directory where you disable host_key_checking
