#!/bin/bash

docker volume create --name nexus-data

sudo cat <<EOT>> /etc/systemd/system/nexus.service

[Unit]
Description=nexus service
After=network.target

[Service]

SyslogIdentifier=nexus.service
ExecStartPre=-/usr/bin/docker create --name nexus3 -p 8081:8081 -v nexus-data:/nexus-data --restart=always sonatype/nexus3
ExecStart=/usr/bin/docker start -a nexus3
ExecStop=-/usr/bin/docker stop --time=0 nexus3

[Install]
WantedBy=multi-user.target
EOT

sudo systemctl daemon-reload
sudo systemctl start nexus.service
sudo systemctl enable nexus.service

# Retrieve initial passwd
# docker exec -it nexus3 /bin/bash
# Retrieve the password for admin
 #cat /var/lib/docker/volumes/nexus-data/_data/admin.password
