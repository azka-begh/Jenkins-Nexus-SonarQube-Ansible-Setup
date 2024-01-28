
#!/bin/bash

#JDK installation
sudo apt update
sudo apt install fontconfig openjdk-17-jre -y
# or
# sudo apt-get install openjdk-11-jdk -y
# or
# apt install openjdk-11-jdk-headless -y
java -version
# Jenkins installation on ubuntu
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y

#When jenkins is set, go to manage jenkins -> nodes -> script -> Run "System.setProperty("hudson.model.DirectoryBrowserSupport.CSP", "")" to enable css
