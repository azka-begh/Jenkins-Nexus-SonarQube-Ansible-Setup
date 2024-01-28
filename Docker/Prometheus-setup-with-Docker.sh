#!/bin/bash
sudo cat <<EOT>> ~/prometheus.yml
global:
  scrape_interval:     15s
  evaluation_interval: 15s
  scrape_timeout:      10s

# Alertmanager configuration
alerting:
  alertmanagers:
  - static_configs:
    - targets:
      # - alertmanager:9093

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  - job_name: 'prometheus'
    static_configs:
    - targets: ['localhost:9090']
  - job_name: 'jenkins'
    metrics_path: /prometheus/
    static_configs:
    - targets: ['192.168.32.13:8080']
EOT


sudo cat <<EOT>> /etc/systemd/system/prometheus.service
[Unit]
Description=prometheus service
After=network.target
[Service]
SyslogIdentifier=prometheus.service
ExecStartPre=-/usr/bin/docker create --name prometheus -p 9090:9090 -v ~/prometheus.yml:/etc/prometheus/prometheus.yml --restart=always prom/prometheus
ExecStart=/usr/bin/docker start -a prometheus
ExecStop=-/usr/bin/docker stop --time=0 prometheus
[Install]
WantedBy=multi-user.target
EOT

sudo systemctl start prometheus
sudo systemctl enable prometheus
