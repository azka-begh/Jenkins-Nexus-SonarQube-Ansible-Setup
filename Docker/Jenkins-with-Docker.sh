#!/bin/bash
docker volume create --name jenkins-data
sudo cat <<EOT>> /etc/systemd/system/jenkins.service
[Unit]
Description=jenkins service
After=network.target
[Service]
SyslogIdentifier=jenkins.service
ExecStartPre=-/usr/bin/docker create --name jenkins -p 8080:8080 -v jenkins-data:/var/jenkins_home --restart=always jenkins/jenkins
ExecStart=/usr/bin/docker start -a jenkins
ExecStop=-/usr/bin/docker stop --time=0 jenkins
[Install]
WantedBy=multi-user.target
EOT

sudo systemctl start jenkins
sudo systemctl enable jenkins

#TO RETRIEVE PASSWORD
#docker exec -it jenkins /bin/bash
#cat /var/jenkins_home/secrets/initialAdminPassword
