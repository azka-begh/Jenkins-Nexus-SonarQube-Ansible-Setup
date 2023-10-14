#!/bin/bash

#JDK installation
sudo apt update
sudo apt install fontconfig openjdk-17-jre
# or
sudo apt-get install openjdk-11-jdk
or
apt install openjdk-11-jdk-headless


java -version

# Jenkins installation on ubuntu
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins

sudo ufw allow 8080
sudo ufw enable
sudo ufw status
