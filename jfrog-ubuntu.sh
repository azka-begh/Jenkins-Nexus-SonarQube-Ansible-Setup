sudo apt update
sudo apt install wget -y
sudo apt install openjdk-8-jre-headless -y

cd /opt/
#latest - https://releases.jfrog.io/artifactory/bintray-artifactory/org/artifactory/oss/jfrog-artifactory-oss/
sudo wget https://releases.jfrog.io/artifactory/bintray-artifactory/org/artifactory/oss/jfrog-artifactory-oss/7.77.3/jfrog-artifactory-oss-7.77.3-linux.tar.gz
sudo tar -xzvf *.tar.gz
sudo mv artifactory* jfrog

sudo adduser --disabled-password --gecos "" jfrog
sudo echo "jfrog ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
sudo chown -R jfrog.jfrog /opt/jfrog/

#sudo vim /etc/systemd/system/jfrog.service

sudo cat <<EOT>> /etc/systemd/system/jfrog.service
[Unit]
Description=jfrog service
After=network.target
[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/jfrog/app/bin/artifactory.sh start
ExecStop=/opt/jfrog/app/bin/artifactory.sh stop
User=jfrog
Restart=on-abort
[Install]
WantedBy=multi-user.target
EOT

sudo systemctl start jfrog
sudo systemctl enable jfrog
sudo systemctl status jfrog
