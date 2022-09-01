#!/bin/sh
sudo apt-get update
sudo apt-get install openjdk-8-jdk -y
sudo cd /opt
wget https://download.sonatype.com/nexus/3/nexus-3.41.1-01-unix.tar.gz
sudo tar -xvf nexus-3.41.1-01-unix.tar.gz
sudo mv nexus-3.41.1-01 /opt/nexus
sudo mv sonatype-work /opt/sonatype-work
sudo chown -R nexus:nexus /opt/nexus
sudo chown -R nexus:nexus /opt/sonatype-work
sudo echo "#run_as_user="nexus" > /opt/nexus/bin/nexus.rc
sed -i 's/2703/512/g' /opt/nexus/bin/nexus.vmoptions
sudo echo "[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
User=nexus
Group=nexus
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Restart=on-abort
[Install]
WantedBy=multi-user.target" >> /etc/systemd/system/nexus.service
sudo systemctl enable nexus
sudo systemctl start nexus
