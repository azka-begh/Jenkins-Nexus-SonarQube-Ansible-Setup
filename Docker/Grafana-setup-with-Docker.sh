#!/bin/bash
sudo cat <<EOT>> /etc/systemd/system/grafana.service
[Unit]
Description=grafana service
After=network.target
[Service]
SyslogIdentifier=grafana.service
ExecStartPre=-/usr/bin/docker create --name grafana -p 3000:3000 -v --restart=always grafana/grafana-enterprise
ExecStart=/usr/bin/docker start -a grafana
ExecStop=-/usr/bin/docker stop --time=0 grafana
[Install]
WantedBy=multi-user.target
EOT

sudo systemctl daemon-reload
sudo systemctl start nexus
sudo systemctl enable nexus 
